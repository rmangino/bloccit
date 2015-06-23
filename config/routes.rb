Rails.application.routes.draw do

  root to: 'welcome#index'

  devise_for :users

  resources :posts
  resources :advertisements
  resources :questions
  resources :topics
  # Equivalent to:
  #                        GET    /topics(.:format)                  topics#index
  #                        POST   /topics(.:format)                  topics#create
  #              new_topic GET    /topics/new(.:format)              topics#new
  #             edit_topic GET    /topics/:id/edit(.:format)         topics#edit
  #                  topic GET    /topics/:id(.:format)              topics#show
  #                        PATCH  /topics/:id(.:format)              topics#update
  #                        PUT    /topics/:id(.:format)              topics#update
  #                        DELETE /topics/:id(.:format)              topics#destroy

  # map /about to WelcomeController.about
  get 'about' => 'welcome#about'
  
end
