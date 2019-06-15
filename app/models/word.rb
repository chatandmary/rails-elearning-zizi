class Word < ApplicationRecord
  validates :content, presence: true

  belongs_to :category

  has_many :choice, dependent: :destroy
  accepts_nested_attributes_for :choice
end
