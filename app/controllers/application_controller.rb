class ApplicationController < ActionController::Base
  # protect_from_forgery unless: -> { request.format.json? }
  protect_from_forgery with: :exception

  helper_method :admin?
  helper_method :current_user

  def require_user
    return current_user if current_user
    not_found
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  private
  def admin?
    current_user.try(:admin?)
  end

  def session_auth
    @_user ||= User.find(session[:user_id]) if session[:user_id].present?
  end

  def token_auth
    @_user ||= User.find_by(token: token_auth_params[:token]) if token_auth_params.present?
  end

  def token_auth_params
    params.permit(:token)
  end

  def current_user
    return session_auth if session_auth
    return token_auth if token_auth
    return nil
  end
end
