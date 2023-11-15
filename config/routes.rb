Rails.application.routes.draw do
  devise_for :users

  resources :users, only: %i(index)
  resources :foods, only: %i(index new create destroy)
  resources :recipes, only: %i(index show)
  resources :general_shopping_lists, only: %i(index)

  get '/public_recipes', to: 'public_recipes#index', as: 'public_recipes'
  root to: 'recipes#index'
end
