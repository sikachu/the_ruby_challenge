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

  resources :games, only: [:show, :new, :create] do
    resources :code_challenges, only: [:show, :update],
      controller: "games/code_challenges"
  end

  resource :presentation, only: :show do
    get :tickets, on: :member
    get :left_screen, on: :member
    get :right_screen, on: :member
  end

  get ":slug", to: redirect(path: "/code_challenges/%{slug}"), slug: /[A-Za-z0-9]{5}/
end
