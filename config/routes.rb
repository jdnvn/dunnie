Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post :registrations, to: 'registrations#create'
  delete :logout, to: 'sessions#logout'
  get :logged_in, to: 'sessions#logged_in'
  resources :sessions, only: [:create]

  resources :rooms do
    post :enter
  end

  resources :local_rooms
  resources :global_rooms

  get 'ably/auth'
end
