Rails.application.routes.draw do
  resources :blogs
  resources :jobs
  resources :resumes

  get 'about', to: 'home#about'
  get 'terms', to: 'home#terms'
  get 'contact', to: 'home#contact'


  devise_for :users , :controllers => { :omniauth_callbacks => "callbacks", registrations: 'registrations' }
  devise_scope :user do
    get 'login', :to => 'devise/sessions#new'
    post 'login', :to => 'devise/sessions#new'
    get 'register', :to => 'devise/registrations#new'
    post 'register', :to => 'devise/registrations#new'
    get 'logout', to: 'devise/sessions#destroy'
    get 'password', to: 'devise/passwords#new'
  end


  root 'home#index'
end
