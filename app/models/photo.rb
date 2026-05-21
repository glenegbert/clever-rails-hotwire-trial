class Photo < ApplicationRecord
  validates :photographer, :src_medium, :source_url, presence: true
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
end
