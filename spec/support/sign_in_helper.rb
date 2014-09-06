module SignInHelper
  def sign_in_as(user)
    if defined?(page)
      page.set_rack_session(current_user_id: user.id)
    else
      allow(controller).to receive(:current_user).and_return(user)
      session[:current_user_id] = user.id
    end
  end

  def sign_in
    sign_in_as create(:user)
  end
end

RSpec.configuration.include SignInHelper, type: :controller
RSpec.configuration.include SignInHelper, type: :feature
