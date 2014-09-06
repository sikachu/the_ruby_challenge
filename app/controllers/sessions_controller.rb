class SessionsController < ApplicationController
  def new
    if params[:redirect_to].to_s.start_with?("/")
      session[:redirect_back_to] = params[:redirect_to]
    end

    redirect_to "/auth/github"
  end

  def create
    self.current_user = User.find_or_create_by_authentication_hash(auth_hash)
    redirect_to session[:redirect_back_to] || code_challenges_path
    session[:redirect_back_to] = nil
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
