Rails.application.routes.draw do

  root to: 'pages#home'

  devise_for :users
  resources :users, only: [:index, :show] do
    resources :jobs, only: [:new, :create]
  end
  resources :events, except: [:index] do
  end
  resources :jobs, only: [:show, :edit, :update, :destroy]
  resource :professionals, only: [:show, :edit, :update] do
  end

  resource :organizers, only: [:show]

  patch "jobs/:id/accept", to: "jobs#accept"

  patch "jobs/:id/decline", to: "jobs#decline"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
