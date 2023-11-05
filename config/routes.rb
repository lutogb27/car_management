Rails.application.routes.draw do
  get 'reservations/index'
  get 'cars/index'
  get 'cars/new'
  devise_for :users
  root to: 'homes#top'
  post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
  get 'users/show'
  resources :users
  resources :cars
  resources :reservations
end
