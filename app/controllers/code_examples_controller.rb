class CodeExamplesController < ApplicationController
  before_action :require_user, only: [:create]

  def create
    code_example = CodeExample.new(code_example_params)
    code_example.user = current_user

    if code_example.save
      response.headers["Location"] = ex_url(code_example)
      render plain: "New Exloc created @ #{ex_url(code_example)}", status: :created
    else
      render plain: "Error creating Exloc.", status: :unprocessable_entity
    end
  end

  private
  def code_example_params
    params.permit(:git)
  end
end
