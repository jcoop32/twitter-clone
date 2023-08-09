Rails.application.routes.draw do
  root 'home#home'
  get 'login', to: 'auth#login_form'
  post 'login', to: 'auth#login'
  get 'signup', to: "auth#new_user"
  post 'signup', to: 'auth#create_user'
end
