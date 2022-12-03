Rails.application.routes.draw do
  get 'my_portfolio', to: "users#my_portfolio"
  get 'my_friends', to: "users#my_friends"
  devise_for :users
  root "welcome#index"
  get 'search_stock', to: "stocks#search"
  get 'search_user', to: "friendships#search"
  resources :user_stocks, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]
  resources :users, only: [ :show ]
end
