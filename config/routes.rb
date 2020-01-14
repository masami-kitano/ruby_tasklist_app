Rails.application.routes.draw do
  root to: 'tasks#index'
  
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :tasks
  resources :users, only: [:new, :create]
end
