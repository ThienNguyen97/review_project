class CitiesController < ApplicationController
  def index
    @cities = City.order_by_name(:name).search_by_name "%#{params[:term]}%"
    render json: @cities.map{|f| {id: f.id, value: f.name}}
  end
end
