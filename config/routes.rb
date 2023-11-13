Rails.application.routes.draw do
  devise_for :users

  resources :users, only: %i(index)
  resources :foods, only: %i(index show)
  resources :recipes, only: %i(index show)
end
