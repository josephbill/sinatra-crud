require 'sinatra'
require 'sinatra/activerecord'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'mini_magick'
require './User'
require './posts'
require './ImageUploader'
require 'sinatra/flash'


configure :development do
    set :database, {adapter: 'sqlite3', database: 'db/database.sqlite3'}
  end


# set :database, { adapter: 'sqlite3', database: 'db/database.sqlite3' }





# Define the routes for the app
get '/' do
  redirect '/users'
end

# Users routes
get '/users' do
  @users = User.all
  erb :users_index
end

get '/users/new' do
  erb :users_new
end

post '/users' do
  @user = User.create(params[:user])
  redirect '/users'
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :users_show
end

get '/users/:id/edit' do
  @user = User.find(params[:id])
  erb :users_edit
end

put '/users/:id' do
  @user = User.find(params[:id])
  @user.update(params[:user])
  redirect '/users'
end

delete '/users/:id' do
  @user = User.find(params[:id])
  @user.destroy
  redirect '/users'
end

# Posts routes
get '/users/:user_id/posts' do
  @user = User.find(params[:user_id])
  @posts = @user.posts
  erb :posts_index
end

get '/users/:user_id/posts/new' do
  @user = User.find(params[:user_id])
  erb :posts_new
end

post '/users/:user_id/posts' do
  @user = User.find(params[:user_id])
 
  puts params[:post][:image].inspect


@post_image = params[:post][:image]["filename"]
puts "IMAGE FIILE NAME"

@post = @user.posts.create(
  "title": params[:post][:title],
  "content": params[:post][:content],
  "image": @post_image
)
  redirect '/users/' + @user.id.to_s + '/posts'
end

get '/users/:user_id/posts/:id' do
  @user = User.find(params[:user_id])
  @post = @user.posts.find(params[:id])
  erb :posts_show
end

get '/users/:user_id/posts/:id/edit' do
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    erb :posts_edit
  end
  
  put '/users/:user_id/posts/:id' do
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.update(params[:post])
    redirect '/users/' + @user.id.to_s + '/posts'
  end
  
  delete '/users/:user_id/posts/:id' do
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.destroy
    redirect '/users/' + @user.id.to_s + '/posts'
  end
  
