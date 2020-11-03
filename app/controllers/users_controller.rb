class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to articles_path, success: "Welcome to AlphaBlog #{@user.username}, you have successfully signed up"
        else
            render 'new'
        end
    end
    def edit
    end
    def update
        if @user.update(user_params)
            redirect_to user_path(@user), success: "User profile  updated successfully."

        else
            render 'edit'
        end
    end
    def show
        @articles = @user.articles.paginate(page: params[:page], per_page: 5)
       
        if params[:search]
            @search_term = params[:search]
            @articles = @articles.search_by(@search_term)
        end
        if params[:order]=== "1"
            @articles = @articles.order(created_at: :desc)
           else 
               @articles = @articles.order(created_at: :ASC)

       end
    end
    def index
        @users = User.paginate(page: params[:page], per_page: 5)
        if params[:search2]
            @search_term = params[:search2]
            @users = @users.search_by(@search_term)
        end
    end
    def destroy
        @user.destroy
        session[:user_id] = nil if @user ==  current_user
        redirect_to root_path, info: "User account and all associated articles were deleted"
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
    def set_user
        @user = User.find(params[:id])
    end
    def require_same_user
        if current_user != @user && !current_user.admin?
            redirect_to @user, danger: "You can only update your own profile"
        end
    end
end