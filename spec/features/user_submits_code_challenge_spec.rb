require "rails_helper"

feature "User submits code challenge" do
  scenario "Signed in user" do
    sign_in_as create(:user)
    visit root_path
    click_on "+ Submit Code Challenge"

    fill_in "Left code sample", with: %(puts "Hello World")
    fill_in "Right code sample", with: %(puts "こんにちは世界")
    choose "Speed"
    click_on "Submit code challenge"

    expect(page).to have_content("Your code challenge has been submitted.")
  end
end
