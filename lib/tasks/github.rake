# require "open-uri"

namespace :github do
  desc "get public data for a user"
  task :user do
    # name = ENV["NAME"]
    task, username = *ARGV  # ARGV => ["github:user", "username"]
    raise "Try: `rake github:user radavis`" unless username

    uri = URI("https://api.github.com/users/#{username}")
    options = { access_token: ENV["GITHUB_API_TOKEN"] }
    uri.query = URI.encode_www_form(options)

    response = Net::HTTP.get_response(uri)
    data = JSON.parse(response.body)
    PP.pp(data)

    task username.to_sym do; end  # shitty way to handle ARGVs. thanks rake.
  end

  desc "get the tarball of a repository: tarball NAME=username/repo"
  task :tarball do
    ext = "tar.gz"
    username, repo = ENV["NAME"]&.split("/")
    raise "Try: `rake github:tarball NAME=exloc/example`" unless username && repo

    options = { access_token: ENV["GITHUB_API_TOKEN"] }
    uri = URI("https://api.github.com/repos/#{username}/#{repo}/tarball/master")
    uri.query = URI.encode_www_form(options)
    response = Net::HTTP.get_response(uri)

    # uri = "#{response['Location']}?access_token=#{ENV["GITHUB_API_TOKEN"]}"
    uri = response["Location"]
    filename = "#{username}-#{repo}.#{ext}"
    open(filename, "wb") do |file|
      file << open(uri).read
    end
    puts(File.exist?(filename) ? "'#{filename}' created" : "Error creating file '#{filename}'")
    # should test that file size matches what the API tells us
  end
end

<<-CURL
curl --verbose \
  --request GET \
  -F "token=$(GITHUB_API_TOKEN)" \
  https://api.github.com/repos/exloc/example/tarball/master
CURL
