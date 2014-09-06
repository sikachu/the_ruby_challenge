class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    if session[:current_user_id]
      @current_user ||= User.find_by_id(session[:current_user_id])
    end
  end

  alias_method :signed_in?, :current_user
  helper_method :signed_in?, :current_user

  def current_user=(user)
    @current_user = user
    session[:current_user_id] = user.try(:id)
  end

  def validate_user
    unless current_user
      redirect_to signin_path(redirect_to: request.path)
    end
  end
end
