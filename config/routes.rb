Rails.application.routes.draw do
  root "static_pages#home"
  get "/category", to: 'categories#home'
  devise_for :users

  get "places/list_place"
  get "detail/index"
  get "search/index"

  resources :users

  resources :places, only: :index
  resources :cities, only: :index
end
