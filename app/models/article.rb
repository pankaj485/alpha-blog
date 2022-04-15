class Article < ApplicationRecord
  belongs_to :user
  # associating categoreis and articles table using has_many and has_many: :through
  has_many :article_categories
  has_many :categories, through: :article_categories

  validates :title, presence: true, length: { minimum: 3, maximum: 30 }
  validates :description, presence: true, length: { minimum: 3, maximum: 100 }
end
