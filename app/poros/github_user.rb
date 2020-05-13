class GithubUser
  attr_reader :name, :url, :avatar_url, :uid
  def initialize(user_details = {})
    @uid = user_details[:id]
    @name = user_details[:login]
    @url = user_details[:url]
    @avatar = user_details[:avatar_url]
  end
end