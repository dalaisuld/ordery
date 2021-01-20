Rails.application.routes.draw do
  get 'dashboard/index'
  root to: 'dashboard#index'
  devise_for :users, :controllers => { :sessions => "sessions" }
  resources :users
  resources :products
end
