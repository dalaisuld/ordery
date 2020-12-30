Rails.application.routes.draw do
  devise_for :users, :controllers => { :sessions => "sessions" }
  root to: 'order#index', as: 'order_index'
end
