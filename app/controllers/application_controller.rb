class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :admin?
  helper_method :current_user

  def require_user
    return current_user if current_user
    raise ActionController::RoutingError.new('Not Found')
  end

  private
  def admin?
    current_user.try(:admin?)
  end

  def session_auth
    User.find(session[:user_id]) if session[:user_id].present?
  end

  def token_auth
    User.find_by(token: params[:token]) if params[:token].present?
  end

  def current_user
    return session_auth if session_auth
    return token_auth if token_auth
    return nil
  end
end
