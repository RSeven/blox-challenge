Rails.application.routes.draw do
  resources :events, except: [ :index ]
  resources :classrooms
  
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'classrooms#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
