Rails.application.routes.draw do

  root to: 'welcome#index'

  devise_for :users

  resources :posts, :advertisements, :questions
  # equivalent to:
  #   get  'posts/index'
  #   get  'posts/show'
  #   get  'posts/new'
  #   get  'posts/edit'

  # map /about to WelcomeController.about
  get 'about' => 'welcome#about'
  
end
