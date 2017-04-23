Rails.application.routes.draw do
  root "home#index"
  resources :home, only: [:index]

  get "/auth/:provider/callback", to: "sessions#create"
  get "/auth/failure", to: "auth_failure#index"
  resources :sessions, only: [:new, :create, :destroy]
end
