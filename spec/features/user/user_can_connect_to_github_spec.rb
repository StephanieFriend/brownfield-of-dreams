require 'rails_helper'

describe 'User', :vcr do
  before(:all) do
    OmniAuth.config.test_mode = true
  end
  before(:each) do
    OmniAuth.config.mock_auth[:github] = nil
  end
  after(:all) do
    OmniAuth.config.test_mode = false
  end
  it 'user can click a link to connect to github' do
    OmniAuth.config.add_mock(:github, {credentials: {token: "abc123"}, extra: {raw_info:{login: "b-baggins"}}})
    user = create(:user) 
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path
    
    click_on "Connect To Github"
    expect(page).to have_content("Signed in with Github!")
    expect(page).to_not have_link("Connect To Github")
  end

  it 'fails like a champ' do
    OmniAuth.config.mock_auth[:github] = :invalid_credentials

    user = create(:user) 
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path
    
    click_on "Connect To Github"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Failed to connect to Github")
  end

end
  
