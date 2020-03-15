class PostTag < ApplicationRecord
  # validates :post, :tag, przesence: true
  belongs_to :post
  belongs_to :tag
end
