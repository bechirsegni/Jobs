Rails.application.routes.draw do
  resources :blogs
  resources :jobs
  resources :resumes

  get 'about', to: 'home#about'
  get 'terms', to: 'home#terms'

  devise_for :users
  devise_scope :user do
    get 'login', :to => 'devise/sessions#new'
    post 'login', :to => 'devise/sessions#new'
    get 'register', :to => 'devise/registrations#new'
    get 'logout', to: 'devise/sessions#destroy'
  end

  root 'home#index'
end
