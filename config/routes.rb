Rails.application.routes.draw do

  get '/products', to: 'products#index', as: 'products'
  get '/products/:id', to: 'products#show', as: 'product'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config


  resources :categories, only: [:show]
  
  get "/about", to: "home#about"
  get "/contact", to: "home#contact"

  root to: "home#index"

  ActiveAdmin.routes(self)

  
end
