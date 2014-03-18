class TrucksController < ApplicationController
  def search
    @trucks = TruckPost.all

    respond_to do |format|
      format.html
      format.js
    end
  end
end
