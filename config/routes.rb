# Frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'topics#index'

  resources :topics do
    resources :comments
  end
end
