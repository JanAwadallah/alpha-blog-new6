class SessionsController < ApplicationController
    def new
    end

    def create
        
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            redirect_to user, info: "Welcome to AlphaBlog"
        else
            redirect_to login_path, warning: "There was something wrong with your login details"
        end
    end

    def destroy
        session[:user_id] = nil 
        redirect_to root_path, success: "Logged out"
    end






end
