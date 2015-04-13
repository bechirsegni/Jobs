Rails.application.routes.draw do
  resources :blogs

  devise_for :users
  resources :jobs
  resources :resumes
      root 'home#index'
  get 'about', to: 'home#about'
  get 'terms', to: 'home#terms'

end
