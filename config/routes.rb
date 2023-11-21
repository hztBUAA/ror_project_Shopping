Rails.application.routes.draw do
  get 'user/show'
  get 'user/index'
  resources :carts
  root to: "home#index"
  get 'home/index'
  get 'home/about'
  devise_for :users
  resources :commodities
  resources :sellers do
    resources :shops
  end
  resources :customers do
    resource :cart do
      resources :orders do
        post 'purchase'
      end
    end
    #resources :records
  end

  resources :categories
  resources :admins
  resources :customers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
