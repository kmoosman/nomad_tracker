require './config/environment'
# require 'sinatra/flash'
require 'pry'
require 'sinatra/base'
require 'sinatra/flash'

class LocationsController < ApplicationController

  get '/locations' do 
    @locations = Location.all
    erb :'/locations/index'
  end

   get '/locations/new' do 
      if !Helpers.is_logged_in?(session)
        flash[:warning] = "Slow down Sally, we need you to log in first!"
          redirect to 'login'
      end
        erb :'/locations/new'
    end

    post '/locations/new' do
      Helpers.redirect_if_not_logged_in(session) 
  
      if !(params.has_value?(""))
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
        redirect to "users/#{@user.slug}"
      else 
        flash[:warning] = "Missing input, please complete each field before submitting"
        redirect to '/locations/new'
      end
    end


    delete '/locations/:location_id/delete' do
      Helpers.redirect_if_not_logged_in(session)
      @location = Location.find(params[:location_id])
      @user = Helpers.current_user(session)
      if @location.user == @user
        @location.delete
      end
      redirect to "users/#{@user.slug}"
    end


    get '/locations/:location_id/edit' do 
      if !Helpers.is_logged_in?(session)
        flash[:warning] = "Woah there, you need to login before you can visit this page"
        redirect to 'login'
      end
      @location = Location.find(params[:location_id])
      @user = Helpers.current_user(session)
      if @location.user == @user
        erb :'/locations/edit'
      else 
        flash[:warning] = "Unauthorized, this location doesn't belong to you!"
        redirect to "users/#{@user.slug}"
      end
    end
  
  
    patch '/locations/:location_id/edit' do
      Helpers.redirect_if_not_logged_in(session)

      @user = Helpers.current_user(session)
      @location = Location.find(params[:location_id])
      if @location.user == @user
        if params
          @location.update(params.except!(:_method, :location_id))
          @location.save
          redirect to "users/#{@user.slug}"
        else 
          flash[:warning] = "Please fill out all of the location information"
          redirect to "/locations/#{@location.id}/edit"
        end
      else 
        flash[:warning] = "Unauthorized, this location doesn't belong to you!"
        redirect to "users/#{@user.slug}"
      end
    end
    

    


end