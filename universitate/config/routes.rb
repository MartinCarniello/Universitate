Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "teachers/new_rating" => 'teachers#new_rating', :as => :new_rating
  get "group_lessons/update_lesson/:id" => 'group_lessons#update_lesson', :as => :update_lesson

  resources :teachers do
    post 'upload_avatar', on: :collection
  end

  resources :ratings, only: [:index, :create, :update]

  resources :group_lessons

  resources :conversations do
    get :load_more_messages
  end

  root 'teachers#index'

  # Action Cable
  mount ActionCable.server => '/cable'
end
