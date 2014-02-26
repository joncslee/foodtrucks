class AddTruckIdToTruckPost < ActiveRecord::Migration
  def change
    add_column :truck_posts, :truck_id, :integer
    add_index :truck_posts, :truck_id
  end
end
