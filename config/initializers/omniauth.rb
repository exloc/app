Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV["GITHUB_KEY"], ENV["GITHUB_SECRET"],
    scope: "public-repo"
  provider :gitlab, ENV['GITLAB_KEY'], ENV['GITLAB_SECRET'],
    scope: "read_user"
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
end
