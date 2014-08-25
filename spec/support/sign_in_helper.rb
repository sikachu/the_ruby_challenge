module SignInHelper
  def sign_in_as(user)
    page.set_rack_session(current_user_id: user.id)
  end
end

RSpec.configuration.include SignInHelper, type: :feature
