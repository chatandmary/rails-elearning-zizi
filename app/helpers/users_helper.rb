module UsersHelper
  def gravatar_for(user, options = { size: 120})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    image_size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?size=#{image_size}"

    # <img src=gravatar_url alt=user.name />
    image_tag gravatar_url, alt: user.name
  end

  def word_all(id)
    answer = current_user.answers.count
  end

  def lesson_count(id)
    lesson = Lesson.find(id)
    lesson.choices.where(correct: true).count
  end

  def category_words(id)
    lesson = Lesson.find(id)
    category = Category.find(lesson.category_id)
    category.words.count
  end

  def category_title(id)
    lesson = Lesson.find(id)
    category = Category.find(lesson.category_id)
    category.title
  end

  def user_follow(id)
    relationship = Relationship.find(id)
    user = User.find(relationship.followed_id)
  end

  def user_follower(id)
    relationship = Relationship.find(id)
    user = User.find(relationship.follower_id)
  end
  

end
