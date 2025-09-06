require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  resources :products
  
  post "cart"  => "carts#create"
  get  "cart"  => "carts#show"
  post "cart/add_item" => "carts#add_item"

  get "up" => "rails/health#show", as: :rails_health_check

  root "rails/health#show"
end
