class PostTag < ApplicationRecord
  validates :post, :tag, presence: true
  belongs_to :post
  belongs_to :tag
end
