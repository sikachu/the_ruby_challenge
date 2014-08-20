Rails.application.routes.draw do
  root "home#index"

  get "auth/:provider/callback" => "sessions#create"
  get "signout" => "sessions#destroy"
end
