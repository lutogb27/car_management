Rails.application.routes.draw do
  get 'reservations/index'
  get 'cars/index'
  devise_for :users
  root to: 'homes#top'
end
