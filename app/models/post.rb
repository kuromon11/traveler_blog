class Post < ApplicationRecord
  validates :post_tags, presence: true
  validates :title, presence: true, length: { maximum: 25 }
  validates :content, presence: true
  validates :images, presence: true, length: { minimum: 1, maximum: 4 }
  belongs_to :user
  has_many :likes
  has_many :comments
  #imagesテーブル
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  # post_tagsテーブル
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  def self.search(search)
    if search
      # 本文とタイトルから検索
      Post.where('content LIKE(?) OR title LIKE(?)', "%#{search}%", "%#{search}%")
    else
      Post.all
    end
  end
  
  #その記事をいいねしているか確認
  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end
end
