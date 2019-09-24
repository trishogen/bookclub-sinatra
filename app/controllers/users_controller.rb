class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect '/clubs'
    end
  end

  post '/signup' do
    if params[:username] == "" or params[:password] == "" or params[:email] == ""
      redirect '/signup'
    else
      user = User.new(:username => params[:username], :password => params[:password], :email => params[:email])
      user.save
      session[:user_id] = user.id
      redirect '/clubs'
    end
  end

  get '/login' do
    if !!logged_in?
      redirect '/clubs'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/clubs'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    if !!logged_in?
      erb :'users/logout'
    else
      redirect '/'
    end
  end

  post '/logout' do
    session.destroy
    redirect '/'
  end

end
