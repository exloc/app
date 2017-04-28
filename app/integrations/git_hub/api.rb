module GitHub
  class API
    class << self
      HOST = "https://api.github.com/"

      PATHS = {
        readme: "/repos/:owner/:repo/readme",
        repo: "/repos/:owner/:repo",
        files: "/repos/:owner/:repo/contents",
        file: "/repos/:owner/:repo/contents/:file"
      }

      def get_attributes(path_name, options)
        url = URI.join(HOST, path(path_name, options))
        uri = URI(url)
        uri.query = URI.encode_www_form(params)
        response = Net::HTTP.get_response(uri)
        JSON.parse(response.body)
      end

      def path(name, options)
        path = PATHS[name].dup
        options.each { |k, v| path[":#{k.to_s}"] &&= v }
        path
      end

      private
      def params
        { access_token: ENV["GITHUB_API_TOKEN"] }
      end
    end
  end
end

<<-NOTES
Get the readme:       GET /repos/:owner/:repo/readme
Get archive of repo:  GET /repos/:owner/:repo/{tarball,zipball}/:ref
Get file contents:    GET /repos/:owner/:repo/contents/:path
  Content-Type: application/vnd.gtihub.VERSION.raw
  Default: application/vnd.github.v3.raw+json
NOTES
