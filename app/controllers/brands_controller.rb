class BrandsController < ApplicationController
  def show
    @brand = Brand.find(params[:id])
    @truck_posts = @brand.truck_posts.where("day_of_week = ?", Date.today.cwday)
  end
end
