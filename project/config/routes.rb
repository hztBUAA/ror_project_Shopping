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
  resources :customers , except: [:edit, :update] do
    get 'purchase/:commodity_id', to: "customers#purchase", as: :purchase
    resource :addresses do
    end
    member do
      get 'recharge' # 充值页面
      post 'process_recharge' # 处理充值请求
    end
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
