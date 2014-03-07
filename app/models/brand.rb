class Brand < ActiveRecord::Base
  has_many :truck_posts, dependent: :destroy
end
