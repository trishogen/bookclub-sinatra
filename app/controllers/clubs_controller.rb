class ClubsController < ApplicationController

  get '/clubs' do
    redirect_if_not_logged_in
    @clubs = Club.all
    erb :'clubs/clubs'
  end

  get '/clubs/new' do
    redirect_if_not_logged_in
    erb :'clubs/new'
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
    redirect_if_not_logged_in
    @club = Club.find_by_slug(params[:slug])

    if @club.nil?
      redirect '/clubs'
    end

    erb :'clubs/show'
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
    redirect_if_not_logged_in

    @club = Club.find_by_slug(params[:slug])
    @posts = @club.posts
    erb :'posts/posts'
  end


  get '/clubs/:slug/posts/new' do
    redirect_if_not_logged_in

    @club = Club.find_by_slug(params[:slug])
    erb :'posts/new'
  end

  post '/clubs/:slug/posts' do
    redirect_if_not_logged_in
    @club = Club.find_by_slug(params[:slug])

    if params[:title] == "" or params[:content] == ""
      redirect "/clubs/#{@club.slug}/posts/new"
    else
      @post = @club.posts.create(title: params[:title], content: params[:content])
      @post.user = current_user
      @post.save

      redirect "/clubs/#{@club.slug}/posts"
    end
  end

  get '/clubs/:slug/posts/:id' do
    redirect_if_not_logged_in

    @club = Club.find_by_slug(params[:slug])
    @post = Post.find(params[:id])
    erb :'posts/show'
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
    end

      redirect "/clubs/#{@club.slug}/posts/#{@post.id}"
  end

  delete '/clubs/:slug/posts/:id' do
    @club = Club.find_by_slug(params[:slug])
    @post = Post.find(params[:id])
    if current_user.id == @post.user_id
      @post.destroy
    end
      redirect "/clubs/#{@club.slug}/posts"
  end
end
