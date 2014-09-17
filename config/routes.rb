Rails.application.routes.draw do
  if Rails.env.production?
    constraints subdomain: "www" do
      get ":any", to: redirect(subdomain: nil, path: "/%{any}"), any: /.*/
    end
  end

  root "home#index"

  get "auth/:provider/callback" => "sessions#create"
  get "signin" => "sessions#new"
  get "signout" => "sessions#destroy"

  resources :code_challenges

  resource :presentation, only: :show do
    get :tickets, on: :member
    get :left_screen, on: :member
    get :right_screen, on: :member
  end
end
