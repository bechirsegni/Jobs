Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  get 'tags/:tag', to: 'jobs#index', as: :tag
  get 'skills/:skill', to: 'resumes#index', as: :skill

  resources :blogs
  resources :jobs
  resources :resumes
  resources :newsletters

  get 'about', to: 'home#about'
  get 'terms', to: 'home#terms'

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
