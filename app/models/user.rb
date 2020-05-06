class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  validates :first_name, presence: true

  enum role: { default: 0, admin: 1 }
  has_secure_password

  def github_repos(limit = nil)
    json = GithubService.new.repos(github_username, github_token)
    repo_objects = json.map {|repo_detail| Repo.new(repo_detail)}
    limit ? repo_objects.take(limit) : repo_objects
  end

  def github_followers(limit = nil)
    json = GithubService.new.followers(github_username, github_token)
    followers = json.map {|user_json| GithubUser.new(user_json)}
    limit ? followers.take(limit) : followers
  end

end
