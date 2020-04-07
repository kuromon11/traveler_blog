class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :image, ImageUploader
  
  validates :gender_id, presence: true
  validates :residence_id, presence: true

  has_many :likes
  has_many :posts
  has_many :comments  # commentsテーブルとのアソシエーション
end
