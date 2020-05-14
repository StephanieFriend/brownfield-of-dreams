class GithubUser
  attr_reader :name, :url, :avatar_url
  def initialize(user_details = {})
    @name = user_details[:login]
    @url = user_details[:url]
    @avatar = user_details[:avatar_url]
  end
end
