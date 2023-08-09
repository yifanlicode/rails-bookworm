Rails.application.routes.draw do
 
  
  resources :orders, only: [:new, :create, :index, :show] do
    get 'checkout', on: :new
  end
  
  resources :addresses, only: [:new, :create]

  resource :cart, only: [:show] do
    post 'add_item/:product_id', to: 'carts#add_item', as: :add_item
    put 'update_item_quantity/:id', to: 'carts#update_item_quantity', as: :update_item_quantity
    delete 'remove_item/:id', to: 'carts#remove_item', as: :remove_item
  end


  get '/products', to: 'products#index', as: 'products'
  get '/products/:id', to: 'products#show', as: 'product'
  
  resources :products do
    collection do
      get 'on_sale'
      get 'new_products'
      get 'recently_updated'
      get 'search'
    end
  end

  resources :categories, only: [:show, :index]
  
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config

  
  get "/about", to: "home#about"
  get "/contact", to: "home#contact"

  root to: "home#index"

  ActiveAdmin.routes(self)

  
end
