class Post < ApplicationRecord
  validates :title, presence: true
  belongs_to :user
  has_many :likes
  has_many :comments  # commentsテーブルとのアソシエーション
  # 削除時に指定したモデル(post_tags)に対してdestroyが実行。
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  mount_uploader :image, ImageUploader

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
