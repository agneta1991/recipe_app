Rails.application.routes.draw do
  devise_for :users

  resources :users, only: %i(index)
  resources :foods, only: %i(index show new create destroy)
  resources :recipes, only: %i(index show)

  root to: 'recipes#index'
end
