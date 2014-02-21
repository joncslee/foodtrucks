class AddIndexToTruckBrandId < ActiveRecord::Migration
  def change
    add_index :trucks, :brand_id
  end
end
