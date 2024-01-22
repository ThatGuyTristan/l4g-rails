Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post "sign_up", to: "users#create"

  get "games", to: "games#index"
  get "games/:id", to: "games#show"

  get "players", to: "players#index"
  get "players/:id", to: "players#show" 
  post "players/:id", to: "players#edit"

  get "player_games", to: "player_games#index"
  post "player_games", to: "player_games#create" 
  delete "player_games", to: "player_games#delete"

  post "login", to: "sessions#create"
  post "logout", to: "sessions#destroy"

  put "account", to: "users#update"
  get "account", to: "users#edit"
  delete "account", to: "users#delete"

  resources :confirmations, only: [:create, :update], param: :confirmation_token
  resources :passwords, only: [:create, :update], param: :password_reset_token
end
