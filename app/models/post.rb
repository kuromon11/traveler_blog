class Post < ApplicationRecord
  validates :title, presence: true
  belongs_to :user
  has_many :likes
  has_many :comments  # commentsテーブルとのアソシエーション
  
  mount_uploader :image, ImageUploader

  def self.search(search)
    if search
      # 本文とタイトルから検索
      Post.where('content LIKE(?) OR title LIKE(?)', "%#{search}%", "%#{search}%")
    else
      Post.all
    end
  end
end
