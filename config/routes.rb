Rails.application.routes.draw do
  get 'dashboard/index'
  root to: 'dashboard#index'
  devise_for :users, :controllers => { :sessions => "sessions" }
  resources :users
  resources :products
  resources :orders

  post 'products/list', :to => 'products#list'
  post 'orders/list', :to => 'orders#list'

end
