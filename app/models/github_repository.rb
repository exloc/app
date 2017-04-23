class GitHubRepository
  attr_reader :repository, :owner

  def initialize(repository, owner)
    @repository = repository
    @owner = owner
  end

  def metadata
    @_metadata_response ||= get(metadata_uri)
    JSON.parse(@_metadata_response.body)
  end

  def files
    @_files_response ||= get(files_uri)
    JSON.parse(@_files_response.body)
  end

  private
  def get(uri)
    Net::HTTP.get_response(uri)
  end

  def metadata_uri
    uri = URI("https://api.github.com/repos/#{owner}/#{repository}")
    uri.query = URI.encode_www_form(params)
    uri
  end

  def files_uri
    uri = URI("https://api.github.com/repos/#{owner}/#{repository}/contents")
    uri.query = URI.encode_www_form(params)
    uri
  end

  def params
    raise "ENV['GITHUB_ACCESS_TOKEN'] not set!" unless ENV["GITHUB_ACCESS_TOKEN"].present?
    { access_token: ENV["GITHUB_ACCESS_TOKEN"] }
  end
end
