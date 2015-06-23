Rails.application.routes.draw do

  root to: 'welcome#index'

  devise_for :users

  resources :advertisements
  resources :questions

  # Nested resources
  # example url: /topics/1/posts/3
  resources :topics do
    resources :posts, except: [:index]
  end

  # map /about to WelcomeController.about
  get 'about' => 'welcome#about'
  
end
