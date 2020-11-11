class CategoriesController < ApplicationController
    before_action :require_admin, except: [:index, :show]
    def new
        @category = Category.new
    end
    def edit
        @category = Category.find(params[:id])
    end

    def show
        @category = Category.find(params[:id])
        @articles = @category.articles.paginate(page: params[:page], per_page: 5)
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

        @categories = Category.paginate(page: params[:page], per_page: 5)
        

    end

    def create
        @category = Category.new(category_params)
        if @category.save
            redirect_to @category, success: "New category created successfully"
        else
            render 'new'
        end

    end

    def update
        @category = Category.find(params[:id])
        if @category.update(params.require(:category).permit(:name))
            redirect_to category_path(@category), success: "Article was updated successfully."
        else
            render 'edit'
        end
    end
    def destroy
        @category = Category.find(params[:id])
        @category.destroy
        redirect_to categories_path

    end

    private

    def category_params
        params.require(:category).permit(:name)
    end

    def require_admin
        if !(logged_in? && current_user.admin?)
            redirect_to categories_path, warning: "Only admin can create new category"
        end
    end

end
