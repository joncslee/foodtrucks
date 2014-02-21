class DropUrlFromTruck < ActiveRecord::Migration
  def change
    remove_column :trucks, :url
  end
end
