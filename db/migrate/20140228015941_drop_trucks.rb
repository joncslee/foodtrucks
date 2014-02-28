class DropTrucks < ActiveRecord::Migration
  def change
    drop_table :trucks
    rename_column :truck_posts, :truck_id, :brand_id
  end
end
