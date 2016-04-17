Rails.application.routes.draw do
  root to: 'home#index'
  resources :guardians
  resources :students
  resources :teachers
  resources :klasses
  resources :units
  resources :schools
end
