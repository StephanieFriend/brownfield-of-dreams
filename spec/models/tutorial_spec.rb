require 'rails_helper'

RSpec.describe Tutorial, type: :model do

  describe 'instance methods' do
    it 'import' do
      playlist_info =  {:kind=>"youtube#playlistListResponse", :etag=>"\"Dn5xIderbhAnUk5TAW0qkFFir0M/pfUdXquW1vZXDfEZHK9qGpYDTjY\"", :pageInfo=>{:totalResults=>1, :resultsPerPage=>5}, :items=> [{:kind=>"youtube#playlist", :etag=>"\"Dn5xIderbhAnUk5TAW0qkFFir0M/Et1BP-5RpkIb7_GVl1nKB2ETJZ4\"", :id=>"PL1cFDQFVTgspB01PHMDMM0U9Ckm7_mNa3", :snippet=> {:publishedAt=>"2020-05-09T21:41:24.000Z", :channelId=>"UCrU1jP7jxsxg_G1PeXfjQ1w", :title=>"hamburger", :description=>"", :thumbnails=> {:default=>{:url=>"https://i.ytimg.com/vi/Wd-ECuaSIEg/default.jpg", :width=>120, :height=>90}, :medium=>{:url=>"https://i.ytimg.com/vi/Wd-ECuaSIEg/mqdefault.jpg", :width=>320, :height=>180}, :high=>{:url=>"https://i.ytimg.com/vi/Wd-ECuaSIEg/hqdefault.jpg", :width=>480, :height=>360}}, :channelTitle=>"Brian Greeson", :localized=>{:title=>"hamburger", :description=>""}}, :contentDetails=>{:itemCount=>1}}]}
      playlist_videos =  [{:kind=>"youtube#playlistItem", :etag=>"\"Dn5xIderbhAnUk5TAW0qkFFir0M/Mot9ag-1gFpM3BUFS_vQXbkdiv8\"", :id=>"UEwxY0ZEUUZWVGdzcEIwMVBITURNTTBVOUNrbTdfbU5hMy41NkI0NEY2RDEwNTU3Q0M2", :contentDetails=>{:videoId=>"Wd-ECuaSIEg", :videoPublishedAt=>"2007-07-25T00:20:52.000Z"}}]
      video_info = {:kind=>"youtube#videoListResponse", :etag=>"SPtkXd5PlCOjDyOJadqjqk8gqdw", :items=> [{:kind=>"youtube#video", :etag=>"gEL1S-hmukGVjf7WT8tTQvnLj2Q", :id=>"Wd-ECuaSIEg", :snippet=> {:publishedAt=>"2007-07-25T00:20:52Z", :channelId=>"UC9lDKlMc5zeXBny5uxBXpgA", :title=>"You're a Hamburger", :description=>"You're a hamburger. You better face up to the facts. \r\n\r\nA short animation to the song 'You're a Hamburger' by the Vestibules. \r\n\r\nMade by me because I have too much time on my hands...", :thumbnails=> {:default=>{:url=>"https://i.ytimg.com/vi/Wd-ECuaSIEg/default.jpg", :width=>120, :height=>90}, :medium=>{:url=>"https://i.ytimg.com/vi/Wd-ECuaSIEg/mqdefault.jpg", :width=>320, :height=>180}, :high=>{:url=>"https://i.ytimg.com/vi/Wd-ECuaSIEg/hqdefault.jpg", :width=>480, :height=>360}}, :channelTitle=>"ehn", :tags=>["You're", "Hamburger", "Vestibules", "song", "animation", "dancing", "hamburger"], :categoryId=>"24", :liveBroadcastContent=>"none", :localized=> {:title=>"You're a Hamburger", :description=>"You're a hamburger. You better face up to the facts. \r\n\r\nA short animation to the song 'You're a Hamburger' by the Vestibules. \r\n\r\nMade by me because I have too much time on my hands..."}}, :contentDetails=>{:duration=>"PT1M41S", :dimension=>"2d", :definition=>"sd", :caption=>"false", :licensedContent=>false, :contentRating=>{}, :projection=>"rectangular"}, :statistics=>{:viewCount=>"41935", :likeCount=>"246", :dislikeCount=>"11", :favoriteCount=>"0", :commentCount=>"41"}}], :pageInfo=>{:totalResults=>1, :resultsPerPage=>1}}
      allow_any_instance_of(YoutubeService).to receive(:playlist_info).and_return(playlist_info)
      allow_any_instance_of(YoutubeService).to receive(:playlist_videos).and_return(playlist_videos)
      allow_any_instance_of(YoutubeService).to receive(:video_info).and_return(video_info)
      
      tutorial = Tutorial.new
      tutorial.playlist_id = "gaifjgjha"
      tutorial.import

      expect(tutorial.title).to eq(playlist_info[:items].first[:snippet][:title])
      expect(tutorial.description).to eq(playlist_info[:items].first[:snippet][:description])
      expect(tutorial.thumbnail).to eq(playlist_info[:items].first[:snippet][:thumbnails][:high][:url])

      expect(tutorial.videos.first.title).to eq(video_info[:items][0][:snippet][:title])
      expect(tutorial.videos.first.description).to eq(video_info[:items][0][:snippet][:description])
      expect(tutorial.videos.first.video_id).to eq(video_info[:items][0][:id])
      expect(tutorial.videos.first.thumbnail).to eq(video_info[:items][0][:snippet][:thumbnails][:high][:url])
    end
  end
end

