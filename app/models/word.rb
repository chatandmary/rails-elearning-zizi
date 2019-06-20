class Word < ApplicationRecord
  validates :content, presence: true

  belongs_to :category

  has_many :answers
  has_many :lessons, through: :answers
  has_many :choices, dependent: :destroy
  accepts_nested_attributes_for :choices  

end
