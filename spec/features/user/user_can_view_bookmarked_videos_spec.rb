require 'rails_helper'

describe 'A registered user' do
  it 'can view bookmarked videos on dashboard sorted by tutorial' do
    tutorial1= create(:tutorial, title: "How to Tie Your Shoes")
    video1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial1)
    video2 = create(:video, title: "The Double Knot Technique", tutorial: tutorial1)
    tutorial2= create(:tutorial, title: "How to Wash Your Hands")
    video3 = create(:video, title: "Lasting 20 Seconds", tutorial: tutorial2)
    video4 = create(:video, title: "What Soap To Use", tutorial: tutorial2)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial1)

    click_on 'Bookmark'

    visit '/dashboard'

    within(".#{tutorial1.id}") do
      expect(page).to have_content(video1.title)
      expect(page).to have_content(video2.title)
      expect(page).to have_no_content(video3.title)
    end

    within(".#{tutorial2.id}") do
      expect(page).to have_content(video3.title)
      expect(page).to have_content(video4.title)
      expect(page).to have_no_content(video1.title)
    end
  end
end
