class Word < ApplicationRecord
  validates :content, presence: true

  belongs_to :category

  has_many :answers
  has_many :lessons, through: :answers
  has_many :choices, dependent: :destroy
  accepts_nested_attributes_for :choices

  validate :check_box

 
  private

  def check_box
    unless choices.collect{ |choice| choice.correct }.count(true) == 1
      errors.add(:choices, "should have only one choice")
    end
  end

end
