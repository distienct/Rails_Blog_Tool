Rails.application.routes.draw do

  resources :users

  resources :categories

  resources :posts do
    resources :comments
    resources :likes, only: [:create, :destroy]
    resources :votes, only: [:create, :destroy, :update]
    resources :favourites, only: [:create, :destroy]
    resources :collaborations
  end

    resources :sessions, only: [:new, :create] do
      delete :destroy, on: :collection
    end

    root "homes#home"

    get "/about" => "homes#about"

    match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]


  end
