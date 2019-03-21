require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base
  # set :views, proc { File.join(root, '../views/') }

  configure do
    
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
	set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/login' do
    erb :'/Users/login'
  end

  post '/login' do 
    @user = User.find_by(:email => params[:email])
  	if @user && @user.authenticate(params[:password])
      session["user_id"] = @user.id
      redirect to "/#{@user.username}"
    else
      redirect to "/signup"
    end
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to '/login'
    else 
     erb :'/Users/sign_up'
    end
  end

  post '/signup' do 
      @user = User.create(params)
      session["user_id"] = @user.id
      redirect to :"/#{@user.username}"
  end

  get '/new' do 
    if !Helpers.is_logged_in?(session)
      redirect to 'login'
    end
    erb :'/users/new'
  end

  post '/new' do 
    @user = Helpers.current_user(session)
    @filename = params[:image_name][:filename]
    file = params[:image_name][:tempfile]
    @location = Location.create(params)
    @location.image_name = @filename
    @location.user_id = @user.id
    @location.save

    File.open("./public/images/#{@filename}", 'wb') do |f|
      f.write(file.read)
    end

    redirect to "/#{@user.username}"
    
  end



  get '/:slug' do
    if !Helpers.is_logged_in?(session)
      redirect to 'login'
    end
    @user = User.find_by_slug(params[:slug])
    all_locations = Location.where("user_id = '1'")
    @locations = all_locations.order(:start_date)
    erb :'/users/show'
  end

  get '/:location_id/edit' do 
    if !Helpers.is_logged_in?(session)
      redirect to 'login'
    end
    @location = Location.find(params[:location_id])
    erb :'/users/edit'
  end


  patch '/:location_id/edit' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    else
      @user = Helpers.current_user(session)
      @location = Location.find(params[:location_id])
      @location.update(params.except!(:_method, :location_id))
      @location.save
      redirect to "/#{@user.username}"
    end

  end


  delete '/:location_id/delete' do
    if Helpers.is_logged_in?(session)
      @location = Location.find(params[:location_id])
      @user = Helpers.current_user(session)
      if @location.user == Helpers.current_user(session)
        @location = Location.find_by_id(params[:location_id])
        @location.delete
        redirect to "/#{@user.username}"
      else
        redirect to '/login'
      end
    else
      redirect to '/login'
    end
  end



end