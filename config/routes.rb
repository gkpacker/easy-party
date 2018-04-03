Rails.application.routes.draw do

  root to: 'users#index'
  devise_for :users
  resources :users, only: [:index, :show] do
    resources :professionals, only: [:show]
    resources :organizers, only: [:show]
  end
  resources :professionals, only: [:edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
