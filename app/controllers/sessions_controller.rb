class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.save
      # send_welcome_email(user) if user.is_new_account?
      session[:user_id] = user.id
      suffix = user.to_s ? ", #{user}" : ""
      flash[:success] = "Welcome back#{suffix}!"
    else
      provider_name = params[:provider].titleize
      flash[:error] = "There was a problem authenticating via #{provider_name}."
    end
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have signed out."
    redirect_to root_path
  end
end
