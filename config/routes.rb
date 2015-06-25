Rails.application.routes.draw do

  root to: 'welcome#index'

  devise_for :users

  resources :advertisements
  resources :questions

  # Nested resources
  # example url: /topics/1/posts/3
  #
  # Because :posts is set to 'shallow: true' we can get:
  #    post_summary       POST   /posts/:post_id/summary(.:format)                  summaries#create
  # instead of:
  #    topic_post_summary POST   /topics/:topic_id/posts/:post_id/summary(.:format) summaries#create
  #
  resources :topics do
    resources :posts, except: [:index], shallow: true do
      resource :summary, except: [:index]
    end
  end

  # map /about to WelcomeController.about
  get 'about' => 'welcome#about'
  
end
