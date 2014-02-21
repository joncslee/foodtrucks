class AddYelpBusinessIdToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :yelp_business_id, :string
    add_index :brands, :yelp_business_id
  end
end
