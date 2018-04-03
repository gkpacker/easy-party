Rails.application.routes.draw do
  get 'user_categories/edit'

  patch 'user_categories/update'

  root to: 'users#index'
  devise_for :users
  resources :users, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
