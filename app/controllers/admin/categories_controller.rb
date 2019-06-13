class Admin::CategoriesController < Admin::ApplicationController
    before_action :admin_user

    def index
      @categories = Category.paginate(page:params[:page], per_page: 5)
    end
  
    def new
      @category = Category.new
    end
  
    def create
      @category = Category.new(category_params)
      if @category.save
        flash[:success] = "Created new lesson!!"
        redirect_to admin_categories_url
      else
        render "new"
      end
    end
  
    def show
      @categories = Category.all 
    end
  
    def edit
      @category = Category.find_by(id:params[:id])
    end
  
    def update
      @category = Category.find_by(id:params[:id])
      if @category.update(category_params)
        flash[:success] = "Updated category!!"
        redirect_to admin_categories_url
      else 
        render 'edit_admin_category'
      end
    end
  
    def destroy
      @category = Category.find(params[:id])
      @category.delete
      flash[:success] = "Deleted category!!"
      @category = nil
      redirect_to admin_categories_url
    end
  
    private 
      # strong parameters
      def category_params
          params.require(:category).permit(:title,:description)
      end

      # 管理者かどうか確認
      def admin_user
        redirect_to(root_url) unless current_user.admin?
      end
end