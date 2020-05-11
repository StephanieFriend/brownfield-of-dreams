class Video < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :users, through: :user_videos
  belongs_to :tutorial

  def self.list_bookmarks
    Video.joins(:tutorial).where("videos.bookmark =?", true).group(:tutorial_id).group("videos.id")
  end
end
