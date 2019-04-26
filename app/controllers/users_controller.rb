require './config/environment'
# require 'sinatra/flash'
require 'pry'
require 'sinatra/base'
require 'sinatra/flash'

class UsersController < ApplicationController


        get '/' do
            erb :index
        end

        get '/login' do
          if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            redirect :"users/#{@user.slug}"
          end
          erb :'/Users/login'
        end
      
        post '/login' do 
          @user = User.find_by(:username => params[:username])
        	if @user && @user.authenticate(params[:password])
            session["user_id"] = @user.id
            redirect to "/users/#{@user.slug}"
          else
            flash[:warning] = "We could not locate your account, please sign up!"
            redirect to "/signup"
          end
        end
      
        get '/signup' do
          if Helpers.is_logged_in?(session)
            flash[:alert] = "You are already signed up in"
            redirect to '/login'
          else 
           erb :'/Users/sign_up'
          end
        end
      
        post '/signup' do 
          if !(params.has_value?(""))
            if User.find_by(:username => params[:username])
              flash[:warning] = "Username is already in use, return to login page or select another username"
              redirect to '/signup'
            else 
              @user = User.create(params)
              session["user_id"] = @user.id
              redirect to :"/users/#{@user.slug}"
            end
          else 
            flash[:warning] = "Missing input, please complete each field before submitting"
            redirect to '/signup'
          end
      
        end

        
          get '/logout' do
            if Helpers.is_logged_in?(session)
              session.clear
            else
              redirect to :'/'
            end
            redirect to :'/'
          end


          
        get '/users/:slug' do
            if !Helpers.is_logged_in?(session)
            flash[:warning] = "Slow down Sally, we need you to log in first!"
            redirect to 'login'
            end
            @user = User.find_by_slug(params[:slug])
            all_locations = @user.locations
            @locations = all_locations.order(:start_date)
            erb :'/users/show'
        end



end


# get locations 
# all locations for all user 