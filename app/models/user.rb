class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable :omniauthableを追加
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  mount_uploader :image, ImageUploader

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        nickname: auth.info.name,
        remote_image_url: auth.info.image.gsub("_normal","") ,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20],
        gender_id: 1,
        residence_id: 1
      )
    end
    user
  end

  private

  def self.dummy_email(auth)
    "#{auth.uid}@example.com"
  end
  # #userに必要な情報
  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.nickname = auth.name
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0, 20] # ランダムなパスワードを作成
  #     user.image = auth.info.image.gsub("_normal","") if user.provider == "twitter"
  #     # user.image = auth.info.image.gsub("picture","picture?type=large") if user.provider == "facebook"
  #   end
  # end
  
  validates :gender_id, presence: true
  validates :residence_id, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :gender
  belongs_to_active_hash :prefecture

  has_many :likes
  has_many :posts
  has_many :comments  # commentsテーブルとのアソシエーション


end
