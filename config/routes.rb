Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  root "static_pages#home"
  get "/about", to: "static_pages#about"

  get "/signup", to: "users#new"
  get "/dashboard", to: "users#top"
  
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users
  resources :relationships,only: [:create, :destroy]
end
