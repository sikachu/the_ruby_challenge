require 'rails_helper'

feature "User authentication" do
  scenario "Sign up with GitHub" do
    user = build_stubbed(:user)
    mock_successful_github_authorization(user)

    visit root_path
    click_on "Sign in with GitHub"

    expect(page).to have_content(user.github_username)
    expect(page).to have_css('h1', text: "My code challenges")
    expect(User.count).to eq 1
  end

  scenario "Sign in with GitHub" do
    user = create(:user)
    mock_successful_github_authorization(user)

    visit root_path
    click_on "Sign in with GitHub"

    expect(page).to have_content(user.github_username)
    expect(User.count).to eq 1
  end

  scenario "Sign out" do
    user = create(:user)
    sign_in_as(user)

    visit root_path
    click_on "Sign out"

    expect(page).not_to have_content(user.github_username)
    expect(page).to have_link("Sign in with GitHub")
  end

  def mock_successful_github_authorization(user)
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: "github",
      uid: user.github_user_id,
      info: OmniAuth::AuthHash::InfoHash.new({
        email: user.email,
        nickname: user.github_username,
        name: user.name,
        image: user.avatar_url
      }),
      credentials: OmniAuth::AuthHash.new({
        token: user.access_token,
        expires: false
      })
    })
  end
end
