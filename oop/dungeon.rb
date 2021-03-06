class Dungeon
  # makes it easy to access the player with:
  # my_dungeon.player.name
  attr_accessor :player

  def initialize player_name
    @player = Player.new(player_name)
    @rooms = []
  end

  def start location
    @player.location = location
    show_current_description
  end

  def show_current_description
    puts find_room_in_dungeon(@player.location).full_description
  end

  def find_room_in_dungeon reference
    @rooms.detect { |room| room.reference == reference }
  end

  def find_room_in_direction direction
    room = find_room_in_dungeon(@player.location).connections[direction]
    # should raise error, but just returns you to your current room
    # still says you go the direction you attempted to go
    if room.nil?
      @player.location
    else
      room
    end
  end

  def go direction
    puts "You go #{direction}"
    @player.location = find_room_in_direction(direction)
    show_current_description
  end

  def add_room reference, name, description, connections
    @rooms << Room.new(reference, name, description, connections)
  end

  class Player
    attr_accessor :name, :location

    def initialize player_name
      @name = player_name
    end
  end

  class Room
    attr_accessor :reference, :name, :description, :connections
    def initialize reference, name, description, connections
      @reference = reference
      @name = name
      @description = description
      @connections = connections
    end

    def full_description
      "#{@name}\n\nYou are in #{@description}"
    end
  end

  # the initialization could be written as:
  # Room = Struct.new(:reference, :name, :description, :connections)

end

my_dungeon = Dungeon.new("Henry")
my_dungeon.add_room(:largecave, "Large Cave", "a large cavernous cave", 
                    {west: :smallcave})
my_dungeon.add_room(:smallcave, "Small Cave", "a small claustrophobic cave",
                    {east: :largecave})

my_dungeon.start(:largecave)
my_dungeon.go(:south)