class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :admin?
  helper_method :current_user

  private
  def admin?
    current_user.try(:admin?)
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end
end
