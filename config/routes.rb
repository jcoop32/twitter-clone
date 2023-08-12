Rails.application.routes.draw do
  # dashboard routes
  root 'home#home'
  post '/', to: 'home#create_tweet'
  get 'tweet/:id', to: 'home#show_tweet'
  resources :tweet, only: [:destroy], to: 'home#destroy'

  # for you page
  get 'for-you', to: 'home#for_you_tweets'
  post 'for-you', to: 'home#create_tweet'

  # follow user
  post '/follow/:id', to: 'user#follow_user'
  resources :friendship, only: [:destroy], to: 'user#unfollow_user'

  # login routes
  get 'login', to: 'user#new_session'
  post 'login', to: 'user#create_session'
  delete 'logout', to: 'user#destroy'

  # signup routes
  get 'signup', to: "user#new_user"
  post 'signup', to: 'user#create_user'

  # user profiles
  get 'user/:id', to: 'user#show_user'
end
