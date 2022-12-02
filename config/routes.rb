Rails.application.routes.draw do
  resources :friends
  get 'my_portfolio', to: "users#my_portfolio"
  devise_for :users
  root "welcome#index"
  get 'search_stock', to: "stocks#search"
  resources :user_stocks, only: [:create, :destroy]
end
