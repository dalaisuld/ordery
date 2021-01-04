Rails.application.routes.draw do
  devise_for :users, :controllers => { :sessions => "sessions" }
  resources :users
  root to: 'orders#index', as: 'order_index'
end
