class CodeExampleImportJob < ApplicationJob
  queue_as :default

  def perform(code_example_id)
    ex = CodeExample.find(code_example_id)
    if ex.git_example? && ex.git.include?("github.com")
      repo = GitHubRepository.new(ex.git)
      # add metadata (exloc.json) and content (exloc.md)
      ex.content = repo.content
      ex.metadata = repo.metadata
      ex.save!
    # elsif ex.git_example? && ex.git.include?("bitbucket.com")
      # import from bitbucket
    else
      logger.info "Not a git example, skipping import..."
    end
  end
end
