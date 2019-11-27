class StaticPagesController < ApplicationController
  def home
    @places = Place.popular_places
    @posts = Post.popular_posts
    @list_name = Place.all.pluck(:name)
    @list_address = Place.all.pluck(:address)
  end
end
