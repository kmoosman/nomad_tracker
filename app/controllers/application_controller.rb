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
    @user = User.create({email: params[:email], password: params[:password]})
    binding.pry
  end

  get '/sign-up' do
    erb :'/Users/sign_up'
  end



end