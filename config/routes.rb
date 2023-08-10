Rails.application.routes.draw do
  root 'home#home'
  get 'login', to: 'sessions#new_session'
  post 'login', to: 'sessions#create_session'
  delete 'logout', to: 'sessions#destroy'
  get 'signup', to: "auth#new_user"
  post 'signup', to: 'auth#create_user'
end
