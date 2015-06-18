Rails.application.routes.draw do
  root to: 'welcome#index'

  get 'welcome/index'
  get 'welcome/about'
  get 'welcome/contact'
  
end
