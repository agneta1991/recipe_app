Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i(index)
  resources :foods, only: %i(index new create destroy)
  resources :recipes, only: %i(index show new create destroy edit update) do
    resources :recipe_foods, only: %i(new create destroy edit update)
  end
  resources :general_shopping_lists, only: %i(index)
  get '/public_recipes', to: 'public_recipes#index', as: 'public_recipes'
  root to: 'public_recipes#index'
end
