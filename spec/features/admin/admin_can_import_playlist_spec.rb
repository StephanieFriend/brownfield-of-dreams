require 'rails_helper'

feature "An admin visiting /tutorials/new" do
  scenario "can click a link to import playlist" do
    admin = create(:admin)
    create_list(:tutorial, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/tutorials/new"
    
    click_link("Import Youtube Playlist")
    fill_in "Playlist Id", with: "$$cash_money$$"
    click_on("Import")

    expect(page).to have_content("Unable to create playlist")

    visit "/admin/tutorials/new"
    
    click_link("Import Youtube Playlist")
    fill_in "Playlist Id", with: "PL1cFDQFVTgspB01PHMDMM0U9Ckm7_mNa3"
    click_on("Import")

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content("Successfully created tutorial.")
    click_link("View it here")
  end

end
