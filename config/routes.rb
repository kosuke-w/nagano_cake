Rails.application.routes.draw do

  devise_for :admins
  devise_for :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :orders
    resources :customers
    resources :genres
    resources :items
    resources :orders
    resources :order_details
  end

  get 'cart_items/destroy_all'
  get 'orders/thanks'
  get 'orders/confirm'
  resources :items
  resources :cart_items
  resources :orders
  resources :addresses

end
