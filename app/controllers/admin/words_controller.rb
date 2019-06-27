class Admin::WordsController < Admin::ApplicationController
  before_action :admin_user

  def new
    @category = Category.find(params[:category_id])
    @word = @category.words.build
    3.times { @word.choices.build }
  end

  def create
    @category = Category.find(params[:category_id])
    @word = @category.words.build(word_params)
    if @word.save
      flash[:success] = "Created new word!!"
      redirect_to admin_categories_url
    else
      render "new"
    end
  end

  def index
    @category = Category.find(params[:category_id])
    @words = @category.words.paginate(page:params[:page], per_page: 5)
  end

  def edit
    @category = Category.find_by(id: params[:category_id])
    @word = Word.find_by(id:params[:id])
  end

  def update
    @category = Category.find_by(id: params[:category_id])
    @word = @category.words.find(params[:id])
    if @word.update(word_params)
        flash[:success] = "Updated new word!!"
        redirect_to admin_category_words_url
      else
        render "edit"
      end
  end

  def destroy
    Word.find(params[:id]).destroy
    flash[:success] = "Deleated new word!!"
    redirect_to admin_category_words_url
  end

  private 
      # strong parameters
      def word_params
          params.require(:word).permit(:content,:category_id, choices_attributes: [:id,:content,:correct])
      end
      

      # 管理者かどうか確認
      def admin_user
        redirect_to(root_url) unless current_user.admin?
      end
end