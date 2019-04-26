class Helpers

    def self.current_user(session)
      @current_user ||= User.find(session[:user_id])
      # memoization
    end
  
    def self.is_logged_in?(session)
        !!User.find_by_id(session[:user_id])
    end

    # redirect if not logged in 

    def self.redirect_if_not_logged_in(session)
      if !is_logged_in?(session)
        redirect to '/login'
      end
    end


  end
  