class LetsEncryptController < ApplicationController
  def show
    if params[:id] == ENV["LETS_ENCRYPT_KEY"]
      render plain: ENV["LETS_ENCRYPT_SECRET"]
    else
      not_found
    end
  end
end
