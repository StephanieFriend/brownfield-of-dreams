class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :ASC) }, inverse_of: :tutorial
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  def import
    service = YoutubeService.new
    playlist = service.playlist_info(playlist_id)
    
    self.title = playlist[:items].first[:snippet][:title]
    self.description = playlist[:items].first[:snippet][:description]
    self.thumbnail = playlist[:items].first[:snippet][:thumbnails][:high][:url]
    
    playlist_videos = service.playlist_videos(playlist_id)
    playlist_videos.each do |playlist_video| 
      video_info = service.video_info(playlist_video[:contentDetails][:videoId])
      video_params = {
        title:        video_info[:items][0][:snippet][:title],
        description:  video_info[:items][0][:snippet][:description],
        video_id:     video_info[:items][0][:id],
        thumbnail:    video_info[:items][0][:snippet][:thumbnails][:high][:url]
      }
      videos.new(video_params) 
    end
  end

end
