Rails.application.routes.draw do

  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: "delete"

  resources :sessions, only: [:new, :create, :destroy]
  resources :posts, only: [:new, :create, :destroy]
  resources :users
  root 'posts#index'
end
