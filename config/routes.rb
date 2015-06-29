Rails.application.routes.draw do

  resources :users, except: [:edit, :update] do
    get :edit, on: :collection

    patch :update, on: :collection

  end

  resources :categories

  resources :posts do
    resources :comments
    resources :likes, only: [:create, :destroy]
    resources :votes, only: [:create, :destroy, :update]
    resources :collaborations
  end

    resources :sessions, only: [:new, :create] do
      delete :destroy, on: :collection
    end

    root "homes#home"

    get "/about" => "homes#about"

  end
