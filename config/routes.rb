Rails.application.routes.draw do
  get 'deliveries/index'
  root to: 'home#index'
  get 'reset', to: 'home#reset'
  get 'admin', to: 'dashboard#index'
  get 'items_imports/new'
  get 'items_imports/create'
  get 'dashboard/index'
  get 'home/:phone_number/:pin_code', to: 'home#show'
  post 'home/set_delivery_client', to: 'home#set_delivery_client'
  post 'home/reset_pin_code', to: 'home#reset_pin_code'
  put 'home', to: 'home#update'
  devise_for :users, controllers: { sessions: "sessions" }
  resources :users
  resources :clients
  resources :products
  resources :orders
  resources :deliveries
  resources :sms_logs
  resources :histories
  resources :items_imports, only: [:new, :create]
  resources :logs
  post 'users/update_password', to: 'users#update_password'
  post 'products/list', to: 'products#list'
  post 'clients/list', to: 'clients#list'
  post 'sms_logs/list', to: 'sms_logs#list'
  post 'orders/list', to: 'orders#list'
  post 'orders/add_cargo', to: 'orders#add_cargo'
  post 'orders/set_delivery', to: 'orders#set_delivery'
  post 'orders/take_products', to: 'orders#take_products'
  post 'orders/cancel_products', to: 'orders#cancel_products'
  post 'orders/complete_all_deliveries', to: 'orders#complete_all_deliveries'
  post 'deliveries/list', to: 'deliveries#list'
  post 'clients/reset_pin_code', to: 'clients#reset_pin_code'

  get 'smstest', to: 'dashboard#smstest'
end
