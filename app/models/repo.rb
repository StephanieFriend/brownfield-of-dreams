class Repo
  attr_reader :url, :name, :id
  def initialize(details = {})
    @url = details[:html_url]
    @name = details[:name]
    @id = details[:id]
  end
end