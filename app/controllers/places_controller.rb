class PlacesController < ApplicationController
  def index
    @places = Place.order_by_name(:name).search_by_name "%#{params[:term]}%"
    render json: @places.map{|f| {id: f.id, value: f.name, city_name: f.city_name}}
  end

  def list_place
    @places = Place.page(params[:page]).per Settings.num_feeds_per_page
  end
end
