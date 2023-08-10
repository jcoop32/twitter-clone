Rails.application.routes.draw do
  # dashboard routes
  root 'home#home'
  # login routes
  get 'login', to: 'sessions#new_session'
  post 'login', to: 'sessions#create_session'
  delete 'logout', to: 'sessions#destroy'
  # signup routes
  get 'signup', to: "auth#new_user"
  post 'signup', to: 'auth#create_user'
end
