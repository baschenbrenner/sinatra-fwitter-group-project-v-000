require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

 get '/' do
   session.clear
   erb :index
 end

 get '/index' do
   session.clear
   erb :index
 end

 get '/login' do
   if session[:user_id] != nil
     redirect to '/tweets'
   else
     erb :login
   end
 end

 get '/signup' do
   if session[:user_id] != nil
     redirect to '/tweets'
   else
   erb :signup
  end
 end

 post '/signup' do
   if params[:username] == "" || params[:email] == "" || params[:password] == ""
     redirect to '/signup'
   else
   @user=User.create(username: params[:username], email: params[:email], password: params[:password])
   session[:user_id]=@user.id
   redirect to '/tweets'
   end
 end

 post '/login' do
        @user = User.find_by(username: params[:username])
        if @user.authenticate(params[:password])
          session[:user_id]=@user.id
          redirect '/tweets'
        else
          flash[:message] ="Password did not authenticate."
          redirect '/login'
        end
 end

 get '/show' do
   @user = User.find( session[:user_id])
   erb :show
 end

 get '/tweets' do

   if User.is_logged_in?(session)
     @user = User.find(session[:user_id])
     erb :tweets
   else
     redirect to '/login'
   end

 end

 get '/logout' do
   session.clear
   redirect to '/login'
 end


 get '/users/:slug' do
      @user= User.find_by_slug( params[:slug])
      erb :show

    end

    post '/tweets' do
      if params[:content] != ""
      Tweet.create(content: params[:content], user_id: session[:user_id])
      redirect to '/show'
      else
        redirect to '/tweets/new'
      end
    end

  get '/tweets/new' do
    erb :new
  end
end
