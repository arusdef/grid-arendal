# frozen_string_literal: true
Backend::Engine.routes.draw do
  devise_for :users, path: 'account',
                     path_names:  { sign_in:  'login',  sign_out: 'logout',
                                    password: 'secret', unlock: 'unlock' },
                     controllers: {
                                    sessions:  'backend/users/sessions',
                                    passwords: 'backend/users/passwords',
                                    unlocks:   'backend/users/unlocks'
                                  },
                     class_name: '::User',
                     module: :devise

  devise_scope :user do
    get 'account/edit', to: 'users/accounts#edit',   as: 'edit_user_account'
    put 'account/:id',  to: 'users/accounts#update', as: 'update_user_account'
  end

  resources :users do
    patch 'deactivate',       on: :member
    patch 'activate',         on: :member
    patch 'make_admin',       on: :member
    patch 'make_publisher',   on: :member
    patch 'make_contributor', on: :member
  end

  resources :partners

  root to: 'admin_home#index'
end
