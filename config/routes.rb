Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post "sign_up", to: "users#create"
  
  post "login", to: "sessions#create"
  post "logout", to: "sessions#destroy"

  put "account", to: "users#update"
  get "account", to: "users#edit"
  delete "account", to: "users#delete"

  # Defines the root path route ("/")
  # root "articles#index"

  resources :confirmations, only: [:create, :edit, :update], param: :confirmation_token
  resources :passwords, only: [:create, :update], param: :password_reset_token
end
