Rails.application.routes.draw do
  root to: "home#index"
  get 'home/index'
  get 'home/about'
  get 'customers/commodities',to: "customers#commodities"
  devise_for :users
  resources :user, only: [:show, :index]

  resources :sellers do
    resources :shops do
      resources :commodities
    end
  end
  resources :customers do
    get 'purchase/:commodity_id', to: "customers#purchase", as: :purchase
    resource :cart do
    end
    resources :orders do
    end
    #resources :records
  end

  resources :categories
  resources :admins do
    member do
      get 'commodities', to: 'admins#commodities'
      get 'orders', to: 'admins#orders'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
