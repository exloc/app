class CodeExampleImportJob < ApplicationJob
  queue_as :default

  def perform(code_example_slug)
    ex = CodeExample.find_by(slug: code_example_slug)
    if ex.git_example? && ex.git.include?("github.com")
      ex_params = GitHubRepository.new(ex.git).to_code_example_params
      ex.assign_attributes(ex_params)
      ex.save!
    # elsif ex.git_example? && ex.git.include?("bitbucket.com")
      # import from bitbucket
    else
      logger.info "#{code_example_slug} is not an importable git example. Skipping..."
    end
  end
end
