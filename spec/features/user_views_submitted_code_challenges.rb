require "rails_helper"

feature "User views submitted code challenge" do
  scenario "Views own submitted code challenge" do
    code_challenge = create(:code_challenge)

    sign_in_as code_challenge.submitter
    visit root_path
    click_on "My code challenges"

    expect(page).to have_content("Code challenge ##{code_challenge.slug}")

    within(".code_challenge") do
      click_on "View"
    end

    expect(page).to have_content("Code Challenge ##{code_challenge.slug}")
    expect(page).to have_content(code_challenge.left_code_sample)
    expect(page).to have_content(code_challenge.right_code_sample)
  end
end
