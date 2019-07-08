Rails.application.routes.draw do
  devise_for :users

  resources :organizations, only: [:index, :create, :edit, :update, :destroy]
  resources :shifts,        only: [:index, :create]

  scope module: :users, path: 'users' do
    resource :join_organization,  only: :update
    resource :leave_organization, only: :update
    resource :update_accounts,    only: [:edit, :update]
  end

  root to: 'organizations#index'
end
