class Truck < ActiveRecord::Base
  belongs_to :brand
  has_many :truck_posts
end
