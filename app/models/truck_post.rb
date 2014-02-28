class TruckPost < ActiveRecord::Base
  belongs_to :brand
  validates_presence_of :day_of_week, :start_time, :end_time
end
