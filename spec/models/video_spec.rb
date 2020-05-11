require 'rails_helper'

RSpec.describe Video do
  it {should belong_to :tutorial}
  it {should have_many(:users).through(:user_videos)}
  it {should have_many(:user_videos).dependent(:destroy)}

  describe 'class methods' do
    it 'list_bookmarks' do
      tutorial1= create(:tutorial, title: "How to Tie Your Shoes")
      video1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial1, bookmark: true)
      tutorial2= create(:tutorial, title: "How to Wash Your Hands")
      video2 = create(:video, title: "Lasting 20 Seconds", tutorial: tutorial2, bookmark: true)
      video3 = create(:video, title: "What Soap To Use", tutorial: tutorial2, bookmark: true)

      expect(Video.list_bookmarks.keys).to eq([tutorial1.title, tutorial2.title])
      expect(Video.list_bookmarks.values).to eq([[video1], [video2, video3]])
    end
  end
end
