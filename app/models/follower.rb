class Follower
  attr_reader :name, :url
  def initialize(details = {})
    @url = details[:html_url]
    @name = details[:login]
  end
end