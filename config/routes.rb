Rails.application.routes.draw do

  root 'welcome#index'
  get '/log_out' => 'sessions#destroy', as: 'log_out'

  resources :sessions, only: [:new, :create, :destroy]
  resources :runs, only: [:new, :create]
  resources :users, only: [:new, :create] do
    resources :runs, only: [:new, :create]
  end
end
