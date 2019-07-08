Rails.application.routes.draw do
  devise_for :users

  resources :organizations, only: [:index, :create]

  root to: 'organizations#index'
end
