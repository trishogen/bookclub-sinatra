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

  get '/clubs/:slug' do
    if !!logged_in?
      @club = Club.find_by_slug(params[:slug])
      erb :'clubs/show'
    else
      redirect '/login'
    end
  end

  get '/clubs/:slug/edit' do
    @club = Club.find_by_slug(params[:slug])
    if current_user.id == @club.user_id
      erb :'clubs/edit'
    else
      redirect "/clubs/#{@club.slug}"
    end
  end

  patch '/clubs/:slug' do
    @club = Club.find_by_slug(params[:slug])
    if params[:name] == "" or params[:description] == ""
      redirect "/clubs/#{@club.slug}/edit"
    elsif current_user.id == @club.user_id
      @club.update(name: params[:name], description: params[:description])
      redirect "/clubs/#{@club.slug}"
    else
      redirect "/clubs/#{@club.slug}"
    end
  end


end
