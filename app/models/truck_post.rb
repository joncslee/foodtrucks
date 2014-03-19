class TruckPost < ActiveRecord::Base
  reverse_geocoded_by :latitude, :longitude
  belongs_to :brand
  validates_presence_of :day_of_week, :start_time, :end_time

  def self.within_time_frame(time_frame)
    case time_frame
    when "breakfast"
      where("start_time BETWEEN '05:00:01' AND '10:59:59'")
    when "lunch"
      where("start_time BETWEEN '11:00:01' AND '15:59:59'")
    when "dinner"
      where("start_time BETWEEN '16:00:01' AND '20:59:59'")
    end
  end
end
