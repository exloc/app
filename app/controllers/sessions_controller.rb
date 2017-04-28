class SessionsController < ApplicationController
  def new
  end

  def create
    auth_service = AuthenticationService.new(auth)
    if auth_service.user.save
      # send_welcome_email(user) if user.new_account?
      session[:user_id] = auth_service.user.id
      flash[:success] = "Welcome back, #{auth_service.user}!"
    else
      flash[:error] = "There was a problem authenticating via #{auth_service.provider}."
    end
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have signed out."
    redirect_to root_path
  end

  private
  def auth
    request.env["omniauth.auth"]
  end
end
