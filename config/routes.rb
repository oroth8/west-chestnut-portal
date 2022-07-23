# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, skip: [:registrations, :sessions, :passwords]
  devise_scope :user do
    get 'login', to: 'devise/sessions#new', as: 'new_session'
    post 'login', to: 'devise/sessions#create', as: 'create_session'
    delete 'logout', to: 'devise/sessions#destroy', as: 'destroy_session'

    get 'password', to: 'devise/passwords#new', as: 'new_password'
    get 'edit-password', to: 'devise/passwords#edit', as: 'edit_password'
    put 'password', to: 'devise/passwords#update', as: 'update_password'
    post 'password', to: 'devise/password#create', as: 'create_password'

    get 'signup-cancel', to: 'devise/registrations#cancel', as: 'cancel_signup'
    get 'signup', to: 'devise/registrations#new', as: 'new_signup'
    get 'signup-edit', to: 'devise/registrations#edit', as: 'edit_signup'
    put 'signup', to: 'devise/registrations#update', as: 'update_signup'
    delete 'signup', to: 'devise/registrations#destroy', as: 'delete_signup'
    post 'signup', to: 'devise/registrations#create', as: 'create_signup'
  end
  resources :users, only: %i[index update]
  resources :units
  resources :organisations

  root "landing_page#index"
  get "/dashboard", to: "dashboard#index", as: "dashboard"
end