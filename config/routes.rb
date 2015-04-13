Rails.application.routes.draw do
  devise_for :users
  resources :jobs
  resources :resumes
      root 'home#index'
end
