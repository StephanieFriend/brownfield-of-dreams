require 'rails_helper'

describe 'As a user', :vcr do
  before(:each) do
    @stephanie = create(:user, first_name: "steph", github_token: ENV['GITHUB_TOKEN'], github_username: ENV['GITHUB_USERNAME'])
    @brian = create(:user, first_name: "brian", github_token: ENV['GITHUB_TOKEN2'], github_username: ENV['GITHUB_USERNAME2'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@stephanie)
  end
  after(:all) do
    User.destroy_all
  end
  it 'I can see a button to add friend if they are registered on this site' do
    visit dashboard_path

    within('.followers') do
      within(".follower-#{@brian.github_username}") do
        expect(page).to have_button('Add as Friend')
      end
    end

    within('.following') do
      within(".follow-#{@brian.github_username}") do
        expect(page).to have_button('Add as Friend')
      end
    end
  end

  it 'I can click a button to add a friend' do
    visit dashboard_path
    expect(@stephanie.friends).to eq([])

    within(".follow-#{@brian.github_username}") do
      click_button('Add as Friend')
    end
    expect(@stephanie.friends).to include(@brian)

    visit dashboard_path

    within(".follow-#{@brian.github_username}") do
      expect(page).to have_no_button("Add as Friend")
    end

    within(".friends") do
      within(".friend-#{@brian.github_username}") do
        expect(page).to have_content(@brian.github_username)
      end
    end
  end
end