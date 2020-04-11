class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  mount_uploader :image, ImageUploader

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.nickname = auth.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20] # ランダムなパスワードを作成
      user.image = auth.info.image.gsub("_normal","") if user.provider == "twitter"
      # user.image = auth.info.image.gsub("picture","picture?type=large") if user.provider == "facebook"
    end
  end
  
  validates :gender_id, presence: true
  validates :residence_id, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :gender
  belongs_to_active_hash :prefecture

  has_many :likes
  has_many :posts
  has_many :comments  # commentsテーブルとのアソシエーション


end
