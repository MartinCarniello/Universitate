Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "teachers/new_rating" => 'teachers#new_rating', :as => :new_rating
  resources :teachers do
    post 'upload_avatar', on: :collection
  end

  resources :ratings, only: [:create]

  resources :conversations

  root 'teachers#index'

  # Action Cable
  mount ActionCable.server => '/cable'
end
