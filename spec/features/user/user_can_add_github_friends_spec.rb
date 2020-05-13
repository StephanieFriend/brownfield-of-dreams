require 'rails_helper'

describe 'User' do
  before(:each) do
    @stephanie = create(:user, github_token: ENV['GITHUB_TOKEN'], github_username: ENV['GITHUB_USERNAME'])
    @brian = create(:user, github_token: ENV['GITHUB_TOKEN2'], github_username: ENV['GITHUB_USERNAME2'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@stephanie)
  end

  it 'is given a link to become friends with another user if they both have accounts and are not already friends' do
    VCR.use_cassette('can_form_friendships') do
      visit dashboard_path

      within('.followers') do
        within(".follower-#{@brian.github_username}") do
          expect(page).to have_button('Add as Friend')
        end
        within(".follower-#{@stephanie.github_username}") do
          expect(page).to have_no_button('Add as Friend')
        end
      end

      within('.following') do
        within(".follow-#{@brian.github_username}") do
          expect(page).to have_button('Add as Friend')
        end
        within(".follow-#{@stephanie.github_username}") do
          expect(page).to have_no_button('Add as Friend')
        end
      end
    end
  end

  it 'can click a link to add a friend' do
    VCR.use_cassette('can_click_a_link_to_add_friend') do
      visit dashboard_path
      expect(@stephanie.friends).to eq([])

      within(".follow-#{@brian.github_username}") do
        click_button('Add as Friend')
      end

      @stephanie.reload
      visit dashboard_path

      within(".follow-#{@brian.github_username}") do
        expect(page).to have_no_button("Add as Friend")
      end

      expect(@stephanie.friends).to eq([@brian])
    end
  end
end