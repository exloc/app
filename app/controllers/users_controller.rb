class UsersController < ApplicationController
  def show
    @user = User.includes(:code_examples).from_param(params[:nickname_provider])
    @code_examples = @user.code_examples
  end
end
