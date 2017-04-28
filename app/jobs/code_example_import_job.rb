class CodeExampleImportJob < ApplicationJob
  queue_as :default

  def perform(code_example_slug)
    ex = CodeExample.find_by(slug: code_example_slug)
    ex.import_from_api
  end
end
