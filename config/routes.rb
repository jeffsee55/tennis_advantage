Rails.application.routes.draw do
  root to: "pages#home"
  resources :products
  resources :messages, only: :create
  resources :pages
  resources :posts
  resources :programs, only: [:show, :index]
  get "home", to: "pages#home", as: "home"
  get "about", to: "pages#about", as: "about"
  get "contact", to: "pages#contact", as: "contact"
  resources :line_items
  resources :orders do
    member do
      patch "purchase", to: "orders#update"
      get "confirm", to: "orders#edit"
    end
  end
  post "line_items/create", to: "line_items#create", as: "create_line_item"

  get "cart", to: "cart_sessions#show"
  delete "empty_cart" => "cart_sessions#destroy", as: "empty_cart"

  get "admin", to: "admin#dashboard", as: "dashboard"

  namespace :admin do
    resources :products
    resources :pages, only: [:index, :edit, :update]
    resources :posts
    resources :programs
    resources :users
    resources :coaches
    resources :orders do
      member do
        patch "ship", to: "orders#ship", as: "ship"
        post "deliver", to: "orders#deliver"
        patch "recalculate_shipping", to: "orders#recalculate_shipping"
      end
    end
    resources :slide_images, only: [:index, :new, :create, :destroy]
    resources :messages, only: [:index, :show, :destroy]
  end

end
