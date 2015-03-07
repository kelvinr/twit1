Rails.application.routes.draw do
  root 'statuses#index'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  resources :users, only: [:new, :create]
  resources :statuses, only: [:new, :create]
  get '/:username' => 'users#show', as: 'user'
end
