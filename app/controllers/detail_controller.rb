class DetailController < ApplicationController
  def index
    @places = Place.find_by name: params[:name]
    @popular_places = Place.popular_places
    @posts = Post.where(place_id: @places.id)
  end
end
