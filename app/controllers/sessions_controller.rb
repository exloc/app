class SessionsController < ApplicationController
  def new
  end

  def create
    user = Authentication.new(auth_params).user
    if user.save
      # send_welcome_email(user) if user.new_account?
      session[:user_id] = user.id
      flash[:success] = "Welcome back, #{user}!"
    else
      flash[:error] = "There was a problem authenticating via #{auth_params['provider']}."
    end
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have signed out."
    redirect_to root_path
  end

  private
  def auth_params
    request.env["omniauth.auth"]
  end
end
