module WordsHelper

  def correct_answer
    @words = word.choices.find_by(correct: true).content
  end

  def correct_answer(lesson_id, word_id)
    answer = Answer.find_by(lesson_id: lesson_id, word_id: word_id)
    Choice.find(answer.choice_id)
  end
  

end
