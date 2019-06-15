class Admin::WordsController < Admin::ApplicationController
  before_action :admin_user

  def new
    @category = Category.find(params[:category_id])
    @word = @category.word.build
    3.times { @word.choice.build }
  end

  def create
    @word = Word.new(word_params)
    if @word.save
      flash[:success] = "Created new word!!"
      redirect_to new_admin_category_word_url
    else
      render "new"
    end
  end

  private 
      # strong parameters
      def word_params
          params.require(:word).permit(:content, choice_attributes: [:content])
      end
      

      # 管理者かどうか確認
      def admin_user
        redirect_to(root_url) unless current_user.admin?
      end
end