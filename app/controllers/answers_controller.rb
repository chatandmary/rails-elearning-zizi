class AnswersController < ApplicationController
  def new
    @lesson = Lesson.find(params[:lesson_id])
    @category = Category.find(@lesson.category_id)
    @word = (@category.words - @lesson.words).first
    if @word.nil?
      @lesson.update_attribute(:result,true)
      @lesson.create_activity(user: current_user)
      redirect_to lesson_url(@lesson)
    end
  end

  def create
    @word = Word.find(params[:word_id])
    @choice = Choice.find(params[:choice_id])
    @answer = Answer.new(answer_params)
    if @answer.save
      redirect_to new_lesson_answer_url(params[:lesson_id])
    end
  end

  private 
  # strong parameters
  def answer_params
      params.permit(:lesson_id, :word_id, :choice_id)
  end

  def lesson_params
    params.permit(:result)
end

  

end
