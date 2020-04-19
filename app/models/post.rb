class Post < ApplicationRecord
  validates :prefecture_id, presence: true
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

  # self.でクラスメソッド
  def self.search(search)
    if search
      # 本文とタイトルから検索
      Post.where('content LIKE(?) OR title LIKE(?)', "%#{search}%", "%#{search}%")
    else
      Post.all
    end
  end

  #タグを保存するメソッド 
  def save_posts(tags) # cuurent_tagsとold_tagsとnew_tagsを変数として定義
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags
  
    # Destroy
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    # Create
    new_tags.each do |new_name|
      blog_tag = Tag.find_or_create_by(name: new_name)
      self.tags << blog_tag #タグ新たに追加
    end
  end
  
  #その記事をいいねしているか確認
  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end
end
