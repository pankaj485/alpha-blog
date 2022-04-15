class ArticleCategory < ApplicationRecord
  # associating categoreis and articles table using has_many and has_many: :through
  belongs_to :article
  belongs_to :category
end
