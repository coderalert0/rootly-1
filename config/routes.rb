# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :incidents, only: :index
  post 'incidents/call', to: 'incidents#call'
  root 'incidents#index'
end
