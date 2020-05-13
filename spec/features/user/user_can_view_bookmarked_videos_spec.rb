require 'rails_helper'

describe 'A registered user' do
  it 'can view bookmarked videos on dashboard sorted by tutorial' do
    tutorial1= create(:tutorial, title: "How to Tie Your Shoes")
    video1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial1)
    tutorial2= create(:tutorial, title: "How to Wash Your Hands")
    video2 = create(:video, title: "Lasting 20 Seconds", tutorial: tutorial2)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial1)

    click_on 'Bookmark'

    visit tutorial_path(tutorial2)

    click_on 'Bookmark'

    visit '/dashboard'

    within ".tutorial-#{tutorial1.title.delete(" ")}" do
      expect(page).to have_link(video1.title)
      expect(page).to have_no_link(video2.title)
    end

    within ".tutorial-#{tutorial2.title.delete(" ")}" do
      expect(page).to have_link(video2.title)
      expect(page).to have_no_link(video1.title)
    end
  end

  it 'cannot see playlist name if no videos are bookmarked' do
    tutorial1= create(:tutorial, title: "How to Tie Your Shoes")
    video1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial1)
    tutorial2= create(:tutorial, title: "How to Wash Your Hands")
    video2 = create(:video, title: "Lasting 20 Seconds", tutorial: tutorial2)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial1)

    click_on 'Bookmark'

    visit '/dashboard'

    expect(page).to have_content(tutorial1.title)
    expect(page).to have_link(video1.title)
    expect(page).to have_no_content(tutorial2.title)
    expect(page).to have_no_link(video2.title)
  end

  it 'can click on title and be redirected to video show page' do
    tutorial1= create(:tutorial, title: "How to Tie Your Shoes")
    video1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial1)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial1)

    click_on 'Bookmark'

    visit '/dashboard'

    within ".tutorial-#{tutorial1.title.delete(" ")}" do
      click_link "#{video1.title}"
    end

    expect(current_path).to eq("/videos/#{video1.id}")
  end
end

