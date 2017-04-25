class CodeExamplesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :require_user, only: [:create]

  def create
    code_example = CodeExample.new(code_example_params)
    code_example.user = current_user

    if code_example.save
      CodeExampleImportJob.perform_later(code_example.id)
      response.headers["Location"] = ex_url(code_example)
      render plain: "New Exloc created @ #{ex_url(code_example)}", status: :created
    else
      render plain: "Error creating Exloc.", status: :unprocessable_entity
    end
  end

  def index
    @code_examples = CodeExample.order(created_at: :desc).limit(20)
  end

  def show
    @ex = CodeExample.find_by(slug: params[:slug])
  end

  private
  def code_example_params
    params.permit(:git)
  end
end
