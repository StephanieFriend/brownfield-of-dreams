require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'relationships' do
    it { should have_many(:user_videos).dependent(:destroy)}
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'instance methods', :vcr do
    it 'github_repos' do     
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0, github_token: ENV['GITHUB_TOKEN'], github_username: ENV['GITHUB_USERNAME'])
      expect(user.github_repos[0].class).to eq(Repo)
    end

    it 'github_followers' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0, github_token: ENV['GITHUB_TOKEN'], github_username: ENV['GITHUB_USERNAME'])
      expect(user.github_followers[0].class).to eq(GithubUser)
    end

    it 'github_following' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0, github_token: ENV['GITHUB_TOKEN'], github_username: ENV['GITHUB_USERNAME'])
      expect(user.github_following[0].class).to eq(GithubUser)
    end

    it "friendable_user?" do
      gh_user1 = GithubUser.new({login: Faker::Games::HalfLife.character })
      gh_user2 = GithubUser.new({login: Faker::Games::HalfLife.character })
      gh_user3 = GithubUser.new({login: Faker::Games::HalfLife.character })
      user1 = create(:user, github_username: gh_user1.name)
      user2 = create(:user, github_username: gh_user2.name)
      user3 = create(:user, github_username: nil)

      expect(user1.friendable_user?(gh_user2)).to eq(true)
      expect(user1.friendable_user?(gh_user3)).to eq(false)
    end
  end
end
