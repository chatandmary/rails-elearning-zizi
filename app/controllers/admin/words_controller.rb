class Admin::WordsController < Admin::ApplicationController
  before_action :admin_user

  def new
    @category = Category.find(params[:category_id])
    @word = @category.word.build
    3.times { @word.choice.build }
  end

  def create
    @category = Category.find(params[:category_id])
    @word = @category.word.build(word_params)
    if @word.save
      flash[:success] = "Created new word!!"
      redirect_to admin_categories_url
    else
      render "new"
    end
  end

  private 
      # strong parameters
      def word_params
          params.require(:word).permit(:content, choice_attributes: [:id,:content,:correct])
      end
      

      # 管理者かどうか確認
      def admin_user
        redirect_to(root_url) unless current_user.admin?
      end
end