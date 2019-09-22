class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect '/' # TODO: redirect to their bookclub page
    end
  end

  post '/signup' do
    if params[:username] == "" or params[:password] == "" or params[:email] == ""
      redirect '/signup'
    else
      user = User.create(:username => params[:username], :password_digest => params[:password], :email => params[:email])
      session[:user_id] = user.id
      redirect '/' # TODO: redirect to their bookclub page
    end
  end

end
