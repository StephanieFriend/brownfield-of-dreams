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
      # response_body = File.read('spec/fixtures/mock/github_following.json')
      # stub_request(:get, "https://api.github.com/user/following").with(
      #       headers: {
      #   	  'Accept'=>'*/*',
      #   	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      #   	  'Authorization'=>'Basic YnJpYW4tZ3JlZXNvbjphMDczZDg3MjE1MjhhZDBmYmE5MTI2YzRlZTI4NTRhZDAxYzg4ZGRi',
      #   	  'User-Agent'=>'Faraday v1.0.1'
      #       }).
      #     to_return(status: 200, body: response_body, headers: {})

      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0, github_token: ENV['GITHUB_TOKEN'], github_username: ENV['GITHUB_USERNAME'])
      expect(user.github_following[0].class).to eq(GithubUser)

    end
  end
end
