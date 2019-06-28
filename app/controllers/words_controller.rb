class WordsController < ApplicationController
  def index
    @user = User.find_by(id: params[:user_id])
    @lessons = Lesson.where(user_id: params[:user_id])
    # @category = Category.find_by(id: params[:category_id])

    # @words = @category.words
  end
end
