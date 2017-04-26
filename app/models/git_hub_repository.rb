class GitHubRepository
  attr_reader :owner, :name

  def initialize(url)
    uri = URI(url)
    raise "#{self} - Invalid Hostname: #{uri.host}" if uri.host != "github.com"

    path = uri.path.split("/")
    @owner = path[1]
    @name = path[2]
    raise "#{self} - Unable to parse url: url" if @owner.empty? || @name.empty?
  end

  def content
    return file_content("exloc.md") if files.include?("exloc.md")
    return file_content("README.md") if files.include?("README.md")
  end

  def metadata
    @_metadata ||= file_content("exloc.json") if files.include?("exloc.json")
    @_metadata ||= {}
    return JSON.parse(@_metadata)
  end

  def to_s
    "Exloc::GitHubRepository{owner:#{@owner},name:#{@name}}"
  end

  def to_code_example_params
    {
      name: metadata["name"],
      description: metadata["description"],
      metadata: metadata,
      content: content
    }
  end

  private
  def get(uri)
    Net::HTTP.get_response(uri)
  end

  def repo
    @_metadata_response ||= get(repo_uri)
    JSON.parse(@_metadata_response.body)
  end

  def files
    @_files_response ||= get(files_uri)
    JSON.parse(@_files_response.body).map { |file| file["path"] }
  end

  def file_content(filename)
    uri = file_uri(filename)
    response ||= get(uri)
    json = JSON.parse(response.body)
    return Base64.decode64(json["content"])
  end

  def host
    "https://api.github.com"
  end

  def repo_uri
    uri = URI("#{host}/repos/#{owner}/#{name}")
    uri.query = URI.encode_www_form(params)
    uri
  end

  def files_uri
    uri = URI("#{host}/repos/#{owner}/#{name}/contents")
    uri.query = URI.encode_www_form(params)
    uri
  end

  def file_uri(path)
    uri = URI("#{host}/repos/#{owner}/#{name}/contents/#{path}")
    uri.query = URI.encode_www_form(params)
    uri
  end

  def params
    { access_token: ENV["GITHUB_API_TOKEN"] }
  end
end

<<-NOTES
Get the readme:       GET /repos/:owner/:repo/readme
Get archive of repo:  GET /repos/:owner/:repo/{tarball,zipball}/:ref
Get file contents:    GET /repos/:owner/:repo/contents/:path
  Content-Type: application/vnd.gtihub.VERSION.raw
  Default: application/vnd.github.v3.raw+json
NOTES
