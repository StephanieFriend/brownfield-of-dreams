class Repo
  attr_reader :url, :name
  def initialize(details = {})
    @url = details[:html_url]
    @name = details[:name]
  end
end