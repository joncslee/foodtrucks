class CreateTruckPosts < ActiveRecord::Migration
  def change
    create_table :truck_posts do |t|
      t.integer :day_of_week, null: false
      t.time :start_time, null: false
      t.time :end_time, null: false
      t.decimal :latitude, precision: 9, scale: 6
      t.decimal :longitude, precision: 9, scale: 6

      t.timestamps
    end

    add_index :truck_posts, :day_of_week
    add_index :truck_posts, [:day_of_week, :start_time, :end_time]
  end
end
