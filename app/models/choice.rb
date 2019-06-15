class Choice < ApplicationRecord
  validates :content, presence: true

  belongs_to :word
end
