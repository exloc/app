class AuthFailureController < ApplicationController
  def index
    flash[:error] = params[:message]
    redirect_to root_path
  end
end
