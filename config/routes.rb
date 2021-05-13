Rails.application.routes.draw do
  resources :events
  resources :classrooms
  root to: 'classrooms#index'
end
