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
    user.clubs.create(name: params[:name], description: params[:description],
                      book_of_the_week: params[:book])
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
      @club.update(name: params[:name], description: params[:description],
                    book_of_the_week: params[:book])
      redirect "/clubs/#{@club.slug}"
    else
      redirect "/clubs/#{@club.slug}"
    end
  end

  delete '/clubs/:slug' do
    @club = Club.find_by_slug(params[:slug])
    if current_user.id == @club.user_id
      @club.destroy
      redirect "/clubs"
    else
      redirect "/clubs/#{@club.slug}"
    end
  end

  get '/clubs/:slug/posts' do
    @club = Club.find_by_slug(params[:slug])
    @posts = @club.posts
    if !!logged_in?
      erb :'posts/posts'
    else
      redirect '/login'
    end
  end


  get '/clubs/:slug/posts/new' do
    @club = Club.find_by_slug(params[:slug])

    if !!logged_in?
      erb :'posts/new'
    else
      redirect '/login'
    end
  end

  post '/clubs/:slug/posts' do
    @club = Club.find_by_slug(params[:slug])

    if !logged_in?
      redirect '/login'
    elsif params[:title] == "" or params[:content] == ""
      redirect "/clubs/#{@club.slug}/posts/new"
    else
      @club.posts.create(title: params[:title], content: params[:content],
                          user_id: current_user.id)
      redirect "/clubs/#{@club.slug}/posts"
    end
  end

  get '/clubs/:slug/posts/:id' do
    if !!logged_in?
      @club = Club.find_by_slug(params[:slug])
      @post = Post.find(params[:id])
      erb :'posts/show'
    else
      redirect '/login'
    end
  end

  get '/clubs/:slug/posts/:id/edit' do
    @club = Club.find_by_slug(params[:slug])
    @post = Post.find(params[:id])
    if current_user.id == @post.user_id
      erb :'posts/edit'
    else
      redirect "/clubs/#{@club.slug}/posts/#{@post.id}"
    end
  end

  patch '/clubs/:slug/posts/:id' do
    @club = Club.find_by_slug(params[:slug])
    @post = Post.find(params[:id])
    if params[:title] == "" or params[:content] == ""
      redirect "/clubs/#{@club.slug}/posts/#{@post.id}/edit"
    elsif current_user.id == @post.user_id
      @post.update(title: params[:title], content: params[:content])
      redirect "/clubs/#{@club.slug}/posts/#{@post.id}"
    else
      redirect "/clubs/#{@club.slug}/posts/#{@post.id}"
    end
  end
end
