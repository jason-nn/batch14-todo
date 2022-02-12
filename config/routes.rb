Rails.application.routes.draw do
  devise_for :users

  root 'categories#index'
  get '/today', to: 'categories#today', as: 'today'

  resources :categories do
    resources :tasks
  end
end
