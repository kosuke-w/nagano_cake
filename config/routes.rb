Rails.application.routes.draw do

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :customers, controllers: {
    registrations: 'customers/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :orders
    resources :customers
    resources :genres do
      collection do
        get 'search'
      end
    end
    resources :items
    resources :order_details
    root to: 'homes#top'
  end

  root to: "homes#top"
  get 'cart_items/destroy_all' => 'cart_items#destroy_all'
  get 'orders/thanks'
  post 'orders/confirm' => 'orders#confirm'
  get 'customers/my_page' => "customers#show"
  get 'customers/unsubscribe' => 'customers#unsubscribe'
  patch 'customers/withdraw' => 'customers#withdraw'
  get 'homes/about' => 'homes#about'
  resources :customers do
    member do
      get "check"
      patch "withdraw"
    end
  end
  resources :items
  resources :cart_items
  resources :orders
  resources :addresses

end
