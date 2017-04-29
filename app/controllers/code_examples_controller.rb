class CodeExamplesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :require_user, only: [:create]

  def create
    code_example = CodeExample.new(code_example_params)
    code_example.user = current_user

    if code_example.save
      CodeExampleImportJob.perform_later(code_example.slug)
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
    @ex = CodeExample.includes(:file_objects).find_by(slug: params[:slug])

    respond_to do |format|
      format.html do
        @files = @ex.file_objects
      end

      format.tarball do
        redirect_to GitHub::Repository.new(@ex.git).tarball_url
      end

      format.zip do
        redirect_to GitHub::Repository.new(@ex.git).zipball_url
      end

      # http://stackoverflow.com/a/33244464/2675670
      # format.tarball do
      #   url = GitHub::Repository.new(@ex.git).tarball_url
      #   file_data = open(url)
      #   send_data(file_data, type: file_data.content_type)
      # end
    end
  end

  private
  def code_example_params
    params.permit(:git)
  end
end
