Rails.application.routes.draw do
  # dashboard routes
  root 'home#home'
  post '/', to: 'home#create_tweet'
  # login routes
  get 'login', to: 'auth#new_session'
  post 'login', to: 'auth#create_session'
  delete 'logout', to: 'auth#destroy'
  # signup routes
  get 'signup', to: "auth#new_user"
  post 'signup', to: 'auth#create_user'
end
