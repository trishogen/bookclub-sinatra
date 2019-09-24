class ClubsController < ApplicationController

  get '/clubs' do
    if !!logged_in?
      @user = current_user
      @clubs = Club.all
      erb :'clubs/clubs'
    else
      redirect '/login'
    end
  end

  get '/clubs/new' do
    if !!logged_in?
      erb :'clubs/new'
    else
      redirect '/login'
    end
  end

  post '/clubs' do
    if params[:name] == "" or params[:description] == ""
      redirect '/clubs/new'
    end
    user = current_user
    user.clubs.create(name: params[:name], description: params[:description])
    user.save
    redirect '/clubs'
  end

end
