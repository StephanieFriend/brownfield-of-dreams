require 'rails_helper'

describe 'visitor sees a video show' do
  it 'vistor clicks on a tutorial title from the home page' do
    tutorial1 = create(:tutorial)
    tutorial1.update(classroom: true)
    video = create(:video, tutorial_id: tutorial1.id)
    
    tutorial2 = create(:tutorial)
    video = create(:video, tutorial_id: tutorial2.id)

    visit '/'

    expect(page).to_not have_content(tutorial1.title)

  end
end
