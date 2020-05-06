class GithubService
  def repos(username, token)
    response = conn(username, token).get('/user/repos')
    JSON.parse(response.body, symbolize_names: true)
  end

  def followers(username, token)
    response = conn(username, token).get('/user/followers')
    JSON.parse(response.body, symbolize_names: true)
  end

  def following(username, token)
    response = conn(username, token).get('/user/following')
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn(username, token)
    Faraday.new(url: 'https://api.github.com') do |req| 
      req.basic_auth(username, token)
    end
  end
end