module CategoriesHelper
  def lesson_result(category)
    lesson = Lesson.find_by(category_id: category.id, user_id: current_user.id)
    if !lesson.nil?
      lesson.result
    end
  end

  def lesson_id(category)
    lesson = Lesson.find_by(category_id: category.id, user_id: current_user.id)
    if !lesson.nil?
      lesson.id
    end
  end
end
