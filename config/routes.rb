Rails.application.routes.draw do


  get 'tags/:tag', to: 'jobs#index', as: :tag
  get 'skills/:skill', to: 'resumes#index', as: :skill


  resources :companies

  resources :blogs  do
    resources :comments
  end

  resources :jobs
  resources :resumes
  resources :newsletters
  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      post :restore
      post :mark_as_read
    end
  end
  resources :messages, only: [:new, :create]


  get 'about', to: 'home#about'
  get 'terms', to: 'home#terms'
  get 'employers', to: 'home#employers'

  get 'contacts', to: 'contacts#new'
  post 'contacts', to: 'contacts#create'

  devise_for :users , :controllers => { :omniauth_callbacks => "callbacks", registrations: 'registrations' }
  devise_scope :user do
    get 'login', :to => 'devise/sessions#new'
    post 'login', :to => 'devise/sessions#new'
    get 'register', :to => 'devise/registrations#new'
    post 'register', :to => 'devise/registrations#new'
    get 'logout', to: 'devise/sessions#destroy'
    get 'password', to: 'devise/passwords#new'
    get 'account', to: 'devise/registrations#edit'
  end


  root 'home#index'
end
