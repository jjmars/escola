Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :guardians
  resources :students
  resources :teachers
  resources :klasses
  resources :units
  resources :schools
end
