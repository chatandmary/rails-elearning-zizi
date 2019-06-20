class LessonsController < ApplicationController
  def show
    @lesson = Lesson.find(params[:id])
    @answer = Answer.find_by(id:[:lesson_id])

  end

  def new
  
  end

  def create
    @user = User.find(params[:user_id])
    @category = Category.find(params[:category_id])
    @lesson = Lesson.new(lesson_params)
    if @lesson.save
      redirect_to new_lesson_answer_url(@lesson)
    end
  end

  private 
  # strong parameters
  def lesson_params
      params.permit(:user_id, :category_id,:result)
  end

end
