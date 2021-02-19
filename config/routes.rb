Rails.application.routes.draw do
  get 'items_imports/new'
  get 'items_imports/create'
  get 'dashboard/index'
  root to: 'dashboard#index'
  devise_for :users, :controllers => { :sessions => "sessions" }
  resources :users
  resources :products
  resources :orders
  resources :sms_logs
  resources :histories
  resources :items_imports, only: [:new, :create]
  resources :logs
  post 'users/update_password', :to => 'users#update_password'
  post 'products/list', :to => 'products#list'
  post 'sms_logs/list', :to => 'sms_logs#list'
  post 'orders/list', :to => 'orders#list'
  post 'orders/add_cargo', :to => 'orders#add_cargo'

end
