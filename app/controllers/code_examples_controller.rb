class CodeExamplesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :require_user, only: [:create]

  def create
    ex = CodeExample.new(ex_params)
    ex.user = current_user

    if ex.save
      CodeExampleImportJob.perform_later(ex.slug)
      response.headers["Location"] = ex_url(ex)
      render plain: "New Exloc created @ #{ex_url(ex)}", status: :created
    else
      render plain: "Error creating Exloc.", status: :unprocessable_entity
    end
  end

  def index
    @code_examples = CodeExample.order(created_at: :desc).limit(20)
  end

  def show
    @ex = CodeExample.includes(:file_objects).find_by(slug: ex_params[:slug])

    respond_to do |format|
      format.html { @files = @ex.file_objects }
      format.tarball { redirect_to GitHub::Repository.new(@ex.git).tarball_url }
      format.zip { redirect_to GitHub::Repository.new(@ex.git).zipball_url }
    end
  end

  private
  def ex_params
    params.permit(:git, :slug)
  end
end
