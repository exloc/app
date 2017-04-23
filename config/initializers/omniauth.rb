raise "ENV['GITHUB_CLIENT_ID'] not set!" unless ENV["GITHUB_CLIENT_ID"].present?
raise "ENV['GITHUB_CLIENT_SECRET'] not set!" unless ENV["GITHUB_CLIENT_SECRET"].present?

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github,
    ENV["GITHUB_CLIENT_ID"],
    ENV["GITHUB_CLIENT_SECRET"],
    scope: 'user'
end
