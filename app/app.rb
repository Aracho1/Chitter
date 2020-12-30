ENV['ENVIRONMENT'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'
require './app/models/message'
require './app/models/user'
require 'data_mapper'
require_relative 'data_mapper_setup'


class Chitter < Sinatra::Base
  enable :sessions, :method_override
  set :session_secret, 'super secret'
  register Sinatra::Flash

  get '/' do
    erb :login, :layout => :layout
  end

  get '/signup' do
    erb :signup, :layout => :layout
  end

  post '/signup' do
    user = User.create(username:params[:username],  
                    name:params[:name], 
                    email:params[:email], 
                    password:params[:password],
                    password_confirmation: params[:password_confirmation])
    
    if user.save
      flash[:notice] = 'The account has been successfully created. Please log in.'
      redirect '/'
    else 
      flash[:errors] = user.errors.full_messages
      redirect '/signup'
    end
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user] = user.id
      flash[:notice] = "Welcome back, #{user.username}!"
      redirect '/home'
    else
      flash[:notice] = "The email or password did not match our records. Please try again."
      redirect '/'
    end
  end

  get '/follow/:username' do
    flash[:notice] = "You are now following @#{params[:username]}"
    redirect '/home'
  end


  get '/home' do
    @user = User.get(session[:user])
    @users = User.all
    @messages = Message.all
    erb :home, :layout => :layout
  end

  post '/new' do
    @user = User.get(session[:user])
    flash[:notice] = "The message exceeds 240 characters." unless Message.create(content: params[:new_message], 
                                                                                user: @user.username, 
                                                                                created_at: DateTime.now.strftime('%a, %d %b %Y %H:%M'))
    redirect '/home'
  end

  delete '/sessions' do
    flash[:notice] = "Goodbye!"
    session.delete(:user)
    redirect '/'
  end

  get '/message/:id/edit' do
    @message = Message.get(params[:id])
    erb :edit
  end

  patch '/message/:id' do
    @message = Message.get(params[:id])
    @message.content = params[:content]
    @message.save
    flash[:notice] = "Succesfully updated."
    redirect '/home'
  end

  delete '/message/:id' do
    Message.get(params[:id]).destroy
    flash[:notice] = "Message has been successfully deleted."
    redirect '/home'
  end

end