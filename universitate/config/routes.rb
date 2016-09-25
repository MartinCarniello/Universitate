Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :teachers do
    post 'upload_avatar', on: :collection
  end

  resources :conversations

  root 'teachers#index'

  # Action Cable
  mount ActionCable.server => '/cable'
end
