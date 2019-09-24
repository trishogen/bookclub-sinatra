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

end
