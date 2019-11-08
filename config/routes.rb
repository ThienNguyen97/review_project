Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  root "static_pages#home"
  get "/category", to: 'categories#home'
  devise_for :users

  get "places/list_place"
  get "detail/index"
  get "search/index"
  get "posts/show"

  scope :admin do
    root "admin#index"
  end

  resources :users do
    member do
      get :newfeed
    end
  end

  resources :places, only: :index
  resources :cities, only: :index
  resources :posts, only: %i(create destroy)
end
