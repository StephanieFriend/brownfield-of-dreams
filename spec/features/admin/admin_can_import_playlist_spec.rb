require 'rails_helper'

feature "An admin visiting /tutorials/new" do
  scenario "can click a link to import playlist" do
    admin = create(:admin)
    create_list(:tutorial, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/tutorials/new"

    click_link("Import YouTube Playlist")

    fill_in "Playlist Id", with: "PL1cFDQFVTgsqO-7pdYHib9u1Cm9t_JsGP"

    click_on("Create")

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content("Successfully created tutorial.")
    click_link("View it here.")
    expect(current_path).to eq(tutorial_path())

    # figure out how to test if each video is being displayed!?

  end
end
