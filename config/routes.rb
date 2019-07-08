Rails.application.routes.draw do
  devise_for :users

  resources :organizations, only: [:index, :create, :edit, :update, :destroy]

  scope module: :users, path: 'users' do
    resource :join_organization, only: :update
  end

  root to: 'organizations#index'
end
