class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :description
      t.integer :creator_id

      t.timestamps
    end
  end
end
