require 'rails_helper'

feature "User authenticates with GitHub" do
  scenario "Sign up with GitHub" do
    mock_successful_github_authorization

    visit root_path
    click_on "Sign in with GitHub"

    expect(page).to have_content("sikachu")
  end

  def mock_successful_github_authorization
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: "github",
      uid: "42",
      info: OmniAuth::AuthHash::InfoHash.new({
        email: "sikachu@example.com",
        nickname: "sikachu",
        name: "Prem Sichanugrist",
        image: "https://avatars.githubusercontent.com/u/42?v=2"
      }),
      credentials: OmniAuth::AuthHash.new({
        token: "123456abcdef",
        expires: false
      })
    })
  end
end
