Rails.application.routes.draw do
  root to: "home#index"
  get 'home/index'
  get 'home/about'
  devise_for :users
  resources :orders
  resources :commodities
  resources :shops
  resources :categories
  resources :admins
  resources :sellers
  resources :customers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
