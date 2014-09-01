Rails.application.routes.draw do
  root "home#index"

  get "auth/:provider/callback" => "sessions#create"
  get "signin" => "sessions#new"
  get "signout" => "sessions#destroy"

  resources :code_challenges, only: [:index, :show, :new, :create]
end
