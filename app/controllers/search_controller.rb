class SearchController < ApplicationController
  def index
    if params[:search_place_name].blank? && params[:location].blank?
      redirect_to root_path
    else
      @places = Place.get_places(params[:search_place_name], params[:search])
    end
  end
end
