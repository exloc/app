Rails.application.routes.draw do
  root "code_examples#index"
  # resources :home, only: [:index]

  get "/auth/:provider/callback", to: "sessions#create"
  get "/auth/failure", to: "auth_failure#index"
  resources :sessions, only: [:new, :create, :destroy]

  resources :ex, controller: :code_examples, only: [:create, :index, :show], param: :slug
  resources :usr, controller: :users, only: [:show], param: :nickname_provider
end
