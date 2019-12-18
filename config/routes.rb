Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Ckeditor::Engine => "/ckeditor"
  root "static_pages#home"
  get "/category", to: 'categories#home'
  devise_for :users

  get "places/list_place"
  get "detail/index"
  get "search/index"
  get "posts/show"
  get "payment", to: 'payment#index'
  # scope :admin do
  #   root "admin#index"
  #   get '/users', to: 'admin#users'
  #   get '/places', to: 'admin#places'
  #   get '/reviews', to: 'admin#reviews'
  # end

  resources :users do
    member do
      get :following, :followers, :newfeed
    end
  end

  resources :places, only: :index
  resources :cities, only: :index
  resources :relationships, only: %i(create destroy)
  resources :reactions, only: %i(show create destroy)
  resources :posts do
    resources :comments, only: %i(show edit create destroy)
  end
end
