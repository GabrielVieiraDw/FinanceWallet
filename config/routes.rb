Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'my_wallet', to: 'users#my_wallet'
  get 'search_stock', to: 'stocks#search'
end
