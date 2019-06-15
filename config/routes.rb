Rails.application.routes.draw do
  root "static_pages#home"
  get "/about", to: "static_pages#about"

  get "/signup", to: "users#new"
  get "/dashboard", to: "users#top"

  get 'relationships/create'
  get 'relationships/destroy'
  
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users do
    member do
      get :following, :followers
    end
  end
  namespace :admin do
    resources :categories do # => /admin/categories etc
      resources :words
    end
  end
  resources :users
  resources :relationships,only: [:create, :destroy]
  resources :categories
  resources :words
  resources :lessons
end
