class Post < ApplicationRecord
  validates :title, :content, :image, presence: true
  belongs_to :user
  has_many :comments  # commentsテーブルとのアソシエーション
end
