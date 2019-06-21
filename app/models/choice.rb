class Choice < ApplicationRecord
  validates :content, presence: true

  belongs_to :word

  has_many :answers
  has_many :lessons, through: :answers
end
