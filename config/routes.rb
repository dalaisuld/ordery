Rails.application.routes.draw do
  get 'items_imports/new'
  get 'items_imports/create'
  get 'dashboard/index'
  root to: 'dashboard#index'
  devise_for :users, :controllers => { :sessions => "sessions" }
  resources :users
  resources :products
  resources :orders
  resources :items_imports, only: [:new, :create]
  post 'users/update_password', :to => 'users#update_password'
  post 'products/list', :to => 'products#list'
  post 'orders/list', :to => 'orders#list'

end
