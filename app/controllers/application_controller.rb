require './config/environment'

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

end