class SessionsController < ApplicationController
  def create
    self.current_user = User.find_or_create_by_authentication_hash(auth_hash)
    redirect_to root_path
  end

  def destroy
    self.current_user = nil
    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
