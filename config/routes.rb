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

  patch "jobs/:id/accept", to: "jobs#accept", as: "job_accept"

  patch "jobs/:id/decline", to: "jobs#decline", as: "job_decline"

  patch "jobs/:id/done", to: "jobs#done", as: "job_done"

  # get "jobs/:id/edit_new_review", to: "jobs#"
  # patch "jobs/:id/new_review", to: "jobs#new_review", as: "new_review"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
