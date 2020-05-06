require 'rails_helper'

describe 'User' do
  it 'user can see followers if they have a token' do
    user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0, github_token: ENV['GITHUB_TOKEN'], github_username: ENV['GITHUB_USERNAME'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_content("Github")
    within("section.github") do
      expect(page).to have_css("section.followers")
      expect(page).to have_css("a.follower")
    end
  end
  
  it 'user can not see followers if they do not have a token' do
    user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to_not have_content("Github")
  end
end
