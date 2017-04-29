module GitHub
  class API
    HOST = "https://api.github.com/"

    PATHS = {
      readme: "/repos/:owner/:repo/readme",
      repo: "/repos/:owner/:repo",
      files: "/repos/:owner/:repo/contents",
      file: "/repos/:owner/:repo/contents/:file",
      tarball: "/repos/:owner/:repo/tarball/master",
      zipball: "/repos/:owner/:repo/zipball/master"
    }

    def initialize(path_name, options = {})
      @path_name = path_name
      @options = options
    end

    def path
      path = PATHS[path_name].dup
      options.each { |k, v| path[":#{k.to_s}"] &&= v }
      path
    end

    def uri
      url = URI.join(HOST, path)
      uri = URI(url)
      uri.query = URI.encode_www_form(params)
      uri
    end

    def url
      URI.join(HOST, path).to_s
    end

    def get_response
      Net::HTTP.get_response(uri)
    end

    def get_attributes
      JSON.parse(get_response.body)
    end

    private
    attr_reader :path_name, :owner, :repo, :options

    def params
      { access_token: ENV["GITHUB_API_TOKEN"] }
    end

    def owner
      options[:owner]
    end

    def repo
      options[:repo]
    end
  end
end

<<-NOTES
Get file contents:    GET /repos/:owner/:repo/contents/:path
  Content-Type: application/vnd.gtihub.VERSION.raw
  Default:      application/vnd.github.v3.raw+json
NOTES
