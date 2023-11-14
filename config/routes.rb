Rails.application.routes.draw do
  devise_for :users

  resources :users, only: %i(index)
  resources :foods, only: %i(index new create destroy)
  resources :recipes, only: %i(index show)
  resources :general_shopping_lists, only: %i(index)

  root to: 'recipes#index'
end
