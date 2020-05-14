class YoutubeService
  def video_info(id)
    params = { part: 'snippet,contentDetails,statistics', id: id }

    get_json('youtube/v3/videos', params)
  end

  def playlist_info(id)
    params = { part: 'id,contentDetails,snippet', id: id }

    get_json('youtube/v3/playlists', params)
  end

  def playlist_videos(id)
    params = { part: 'id,contentDetails', playlistId: id }
    response = get_json('youtube/v3/playlistItems', params)
    videos = response[:items]
    while response[:nextPageToken]
      params = { part: 'id,contentDetails', playlistId: id,
                 pageToken: response[:nextPageToken] }
      response = get_json('youtube/v3/playlistItems', params)
      videos  += response[:items]
    end
    videos
  end

  private

  def get_json(url, params)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://www.googleapis.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['YOUTUBE_API_KEY']
    end
  end
end
