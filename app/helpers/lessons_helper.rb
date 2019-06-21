module LessonsHelper
  def count_correct
     @lesson.choices.where(correct: true).count
  end
end
