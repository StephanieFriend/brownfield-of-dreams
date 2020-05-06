require 'rails_helper'

describe 'User' do
  it 'user can sign in' do
      user = User.create(
        email: 'user@email.com', 
        password: 'password', 
        first_name:'Jim', 
        role: 0)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_content("Github")
    within("section.github") do
      expect(page).to have_link(".repo", count: 5)
    end
  end
end
