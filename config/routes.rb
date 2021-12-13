Rails.application.routes.draw do
  resources :likes
  resources :comments
  resources :tags
  resources :videos
  resources :channels
  resources :users
  get 'login' , to: 'users#login'
  post 'login' , to: 'users#check_login'
  get 'main' , to: 'users#main'
  get 'test' , to: 'users#test'
  get 'my_channel' , to:'channels#my_channel'
  post 'my_channel' , to:'channels#my_channel'
  delete 'Log-out' , to: 'users#logout'
  post 'channels/new' , to: 'channels#new'
  get 'tag/:tag' , to: 'videos#select_tag'
  get '/all_channel' , to: 'channels#all_channel'
  get 'channel/:channel_name' , to: 'channels#this_channel'
  get 'select_tag' , to: 'videos#select_tag'
  get 'tag' , to: 'videos#show_tag'
  post '/channels/:id/follow', to: "channels#follow", as: "follow_channel"
  post '/channels/:id/unfollow', to: "channels#unfollow", as: "unfollow_channel"
  post '/videos/:id/like', to: "videos#like", as: "like_channel"
  post '/videos/:id/unlike', to: "videos#unlike", as: "unlike_channel"
  post '/videos/:id' , to: 'videos#create_comment'
  post '/follow/:tag', to: "videos#follow_tag"
  post '/unfollow/:tag', to: "videos#unfollow_tag"
  post 'select_tag' , to: 'videos#select_tag'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
