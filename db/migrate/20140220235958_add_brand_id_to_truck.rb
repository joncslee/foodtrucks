class AddBrandIdToTruck < ActiveRecord::Migration
  def change
    add_column :trucks, :brand_id, :integer
  end
end
