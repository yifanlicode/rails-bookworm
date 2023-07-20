Rails.application.routes.draw do

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :products, only: [:index, :show]



  get "/about", to: "home#about"
  get "/contact", to: "home#contact"

  root to: "home#index"

  ActiveAdmin.routes(self)

  
end
