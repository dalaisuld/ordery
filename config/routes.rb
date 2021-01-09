Rails.application.routes.draw do
  root to: 'orders#index', as: 'order_index'
  devise_for :users, :controllers => { :sessions => "sessions" }
  resources :users
  resources :products
end
