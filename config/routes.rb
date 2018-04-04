Rails.application.routes.draw do

  root to: 'pages#home'

  devise_for :users
  resources :users, only: [:index, :show] do
  end
  resources :events, except: [:index] do
  end
  resources :jobs, only: [:new, :create, :show, :edit, :update, :destroy]
  resource :professionals, only: [:show, :edit, :update]
  resource :organizers, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
