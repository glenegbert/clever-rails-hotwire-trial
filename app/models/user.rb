class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  has_many :likes, dependent: :destroy
  has_many :liked_photos, through: :likes, source: :photo
end
