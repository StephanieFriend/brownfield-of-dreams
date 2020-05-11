class Video < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :users, through: :user_videos
  belongs_to :tutorial

  def self.list_bookmarks
    tutorial_videos = joins(:tutorial).where("videos.bookmark =?", true).order(:tutorial_id).order(:position)
    tutorial_videos.group_by { |video| video.tutorial.title }
  end
end
