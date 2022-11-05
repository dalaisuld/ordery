Rails.application.routes.draw do
  get 'cargo_price/index'
  get 'incomplete/index'
  get 'product_report/index'
  get 'deliveries/index'
  root to: 'home#index'
  get 'admin', to: 'dashboard#index'
  get 'items_imports/new'
  get 'items_imports/create'
  get 'dashboard/index'
  # get 'home/:phone_number', to: 'home#show'
  post 'home', to: 'home#show'
  get 'home', to: 'home#show'
  get 'reset', to: 'home#reset'
  post 'home/reset_pin_code', to: 'home#reset_pin_code'
  post 'home/set_delivery_client', to: 'home#set_delivery_client'
  put 'home', to: 'home#update'

  get 'product_report', to: 'product_report#index'
  get 'sells', to: 'sells#index'
  get 'config', to: 'config#index'
  post 'config/update', to: 'config#update'

  get 'clients/:id/orders', to: 'clients#orders'
  get 'clients/:id/print', to: 'clients#print'
  get 'clients/:id/print_cancel', to: 'clients#print_cancel'
  get 'clients/:id/print_delivery', to: 'clients#print_delivery'

  devise_for :users, controllers: { sessions: "sessions" }
  resources :users
  resources :clients
  resources :products
  resources :orders
  resources :deliveries
  resources :sms_logs
  resources :reports
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

  post 'product_report/sell', to: 'product_report#sell_product'

  get 'smstest', to: 'dashboard#smstest'
end
