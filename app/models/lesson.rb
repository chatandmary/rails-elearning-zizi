class Lesson < ApplicationRecord
  has_many :answers
  has_many :words, through: :answers
  has_many :choices, through: :answers
  belongs_to :user
  belongs_to :category
end
