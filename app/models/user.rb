class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, if: :password
  validates :first_name, presence: true

  enum role: { default: 0, admin: 1 }
  has_secure_password

  def github_repos(limit = nil)
    json = GithubService.new.repos(github_username, github_token)
    repo_objects = json.map { |repo_detail| Repo.new(repo_detail) }
    limit ? repo_objects.take(limit) : repo_objects
  end

  def github_followers
    json = GithubService.new.followers(github_username, github_token)
    json.map { |user_detail| GithubUser.new(user_detail) }
  end

  def github_following
    json = GithubService.new.following(github_username, github_token)
    json.map { |user_detail| GithubUser.new(user_detail) }
  end

  def friendable_user?(github_user)
    unless (user_to_friend = User.find_by(github_username: github_user.name))
      return false
    end

    friends.exclude?(user_to_friend)
  end
end
