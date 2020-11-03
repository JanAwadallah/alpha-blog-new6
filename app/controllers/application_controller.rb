class ApplicationController < ActionController::Base
    before_action :set_cache_headers

    helper_method :current_user, :logged_in?

    add_flash_types :danger, :info, :success, :warning

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
            
    end


    def logged_in?
        !!current_user

    end

    def require_user
        if !logged_in?
            redirect_to login_path, danger: "You must be logged in to visit this page"
        end
    end
    private

def set_cache_headers
  response.headers["Cache-Control"] = "no-cache, no-store"
  response.headers["Pragma"] = "no-cache"
  response.headers["Expires"] = "Mon, 01 Jan 1990 00:00:00 GMT"
end
end


