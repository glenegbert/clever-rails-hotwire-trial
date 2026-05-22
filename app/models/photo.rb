class Photo < ApplicationRecord
  scope :with_likes_count, -> { left_joins(:likes).select("photos.*, COUNT(likes.id) AS likes_count").group(:id) }

  validates :photographer, :src_medium, :source_url, presence: true
  validates :source_url, format: { with: /\Ahttps?:\/\/.*\z/i }
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
end
