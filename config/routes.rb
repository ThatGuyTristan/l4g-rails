Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post "sign_up", to: "users#create"
  post "login", to: "sessions#create"
  post "logout", to: "sessions#destroy"

  # Defines the root path route ("/")
  # root "articles#index"

  resources :confirmations, only: [:create, :edit, :new], param: :confirmation_token

end
