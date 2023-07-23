Rails.application.routes.draw do

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
