Rails.application.routes.draw do
  root 'users#index'

  get '/login'    => 'sessions#new'
  post '/login'   => 'sessions#create'
  get '/logout'   => 'sessions#destroy'
  get '/timeline' => 'users#timeline'
  get '/mentions' => 'users#mentions'

  resources :users, only: [:new, :create] do
    member do
      post 'follow'
      post 'unfollow'
    end
  end

  resources :hashtags, only: :show

  resources :statuses, only: [:new, :create] do
    member do
      post 'retweet'
    end
  end
  get '/:username' => 'users#show', as: 'user'
end
