class TrucksController < ApplicationController
  def search
    @address = Rails.env.production? ? request.location.address : nil

    if request.xhr?
      # perform search for today
      # geo query: near(address, radius)
      @trucks = TruckPost.where('day_of_week = ?', Date.today.cwday).
        within_time_frame(params[:time_frame]).
        near(params[:address], 2)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end
