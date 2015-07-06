Rails.application.routes.draw do

  root to: 'welcome#index'

  devise_for :users
  resources :users, only: [:show, :index, :update]

  resources :advertisements
  resources :questions

  # Nested resources
  resources :topics do
    resources :posts, except: [:index], controller: 'topics/posts'
  end

  resources :posts, only: [:index] do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]

    # Routes for Post voting buttons
    post '/up-vote'   => 'votes#up_vote',   as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end

  # map /about to WelcomeController.about
  get 'about' => 'welcome#about'

end
