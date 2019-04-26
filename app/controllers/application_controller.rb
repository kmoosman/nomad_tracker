require './config/environment'
# require 'sinatra/flash'
require 'pry'
require 'sinatra/base'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base
  register Sinatra::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
	set :session_secret, "password_security"
  end


  # get '/login' do
  #   if Helpers.is_logged_in?(session)
  #     @user = Helpers.current_user(session)
  #     redirect :"/#{@user.username}"
  #   end
  #   erb :'/Users/login'
  # end

  # post '/login' do 
  #   @user = User.find_by(:email => params[:email])
  # 	if @user && @user.authenticate(params[:password])
  #     session["user_id"] = @user.id
  #     redirect to "/#{@user.username}"
  #   else
  #     flash[:warning] = "We could not locate your account, please sign up!"
  #     redirect to "/signup"
  #   end
  # end

  # get '/signup' do
  #   if Helpers.is_logged_in?(session)
  #     flash[:alert] = "You are already logged in"
  #     redirect to '/login'
  #   else 
  #    erb :'/Users/sign_up'
  #   end
  # end

  # post '/signup' do 
  #   if !(params.has_value?(""))
  #     @user = User.create(params)
  #     session["user_id"] = @user.id
  #     redirect to :"/#{@user.username}"
  #   else 
  #     flash[:warning] = "Missing input, please complete each field before submitting"
  #     redirect to '/signup'
  #   end

  # end

  # get '/new' do 
  #   if !Helpers.is_logged_in?(session)
  #     flash[:warning] = "Slow down Sally, we need you to log in first!"
  #     redirect to 'login'
  #   end
  #   erb :'/users/new'
  # end

  # get '/logout' do
  #   if Helpers.is_logged_in?(session)
  #     session.clear
  #   else
  #     redirect to :'/'
  #   end
  #   redirect to :'/'
  # end

  # post '/new' do 
  #   if !(params.has_value?(""))
  #     @user = Helpers.current_user(session)
  #     @filename = params[:image_name][:filename]
  #     file = params[:image_name][:tempfile]
  #     @location = Location.create(params)
  #     @location.image_name = @filename
  #     @location.user_id = @user.id
  #     @location.save

  #     File.open("./public/images/#{@filename}", 'wb') do |f|
  #       f.write(file.read)
  #     end
  #     redirect to "/#{@user.username}"
  #   else 
  #     flash[:warning] = "Missing input, please complete each field before submitting"
  #     redirect to '/new'
  #   end
  # end

  # get 'users/:slug' do
  #   if !Helpers.is_logged_in?(session)
  #     flash[:warning] = "Slow down Sally, we need you to log in first!"
  #     redirect to 'login'
  #   end
  #   @user = User.find_by_slug(params[:slug])
  #   all_locations = @user.locations
  #   @locations = all_locations.order(:start_date)
  #   erb :'/users/show'
  # end

  # delete 'locations/:location_id/delete' do
  #   if Helpers.is_logged_in?(session)
  #     @location = Location.find(params[:location_id])
  #     @user = Helpers.current_user(session)
  #     if @location.user == Helpers.current_user(session)
  #       @location = Location.find_by_id(params[:location_id])
  #       @location.delete
  #       redirect to "/#{@user.username}"
  #       # redirect to  user slug not username
  #     else
  #       redirect to '/login'
  #     end
  #   else
  #     redirect to '/login'
  #   end
  # end

  # get 'locations/:location_id/edit' do 
  #   if !Helpers.is_logged_in?(session)
  #     flash[:warning] = "Woah there, you need to login before you can visit this page"
  #     redirect to 'login'
  #   end
  #   @location = Location.find(params[:location_id])
  #   erb :'/users/edit'
  # end


  # https://help.learn.co/technical-support/local-environment/mac-osx-manual-environment-set-up 
  # https://rvm.io/rubies/default

  # patch 'locations/:location_id/edit' do
  #   if !Helpers.is_logged_in?(session)
  #     redirect to '/login'
  #   else
  #     @user = Helpers.current_user(session)
  #     @location = Location.find(params[:location_id])
  #     if params
  #     @location.update(params.except!(:_method, :location_id))
  #     @location.save
  #     redirect to "/#{@user.username}"
  #     end

  #   end
  # end

end