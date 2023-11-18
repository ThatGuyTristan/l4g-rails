Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post "sign_up", to: "users#create"

  get "players", to: "players#index"
  get "players/:id", to: "players#show" 
  post "players/:id", to: "players#edit"

  
  # Defines the root path route ("/")
  # root "articles#index"

  resources :confirmations, only: [:create, :edit, :new], param: :confirmation_token

end
