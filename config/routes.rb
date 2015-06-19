Rails.application.routes.draw do

  root to: 'welcome#index'

  resources :posts
  # shorter way of stating CRUD routes:
  #   get 'posts/index'
  #   get 'posts/show'
  #   get 'posts/new'
  #   get 'posts/edit'

  get 'about' => 'welcome#about'
  
end
