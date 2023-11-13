Rails.application.routes.draw do
  get 'users/show'
  get 'cars/index'
  devise_for :users
  root to: 'homes#top'
  post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
  resources :users
  resources :cars
  resources :reservations do
    collection do
    post 'confirm'
    end
  end
end
