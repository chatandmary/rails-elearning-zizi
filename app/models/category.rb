class Category < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  has_many :word
end
