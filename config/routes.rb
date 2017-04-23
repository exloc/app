Rails.application.routes.draw do
  root "home#index"
  resources :home, only: [:index]

  get '/auth/:provider/callback', to: 'sessions#create'
  resources :sessions, only: [:new, :create, :destroy]
end
