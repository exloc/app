source "https://rubygems.org"
ruby "2.4.1"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.0.2"
gem "pg", "~> 0.18"
gem "puma", "~> 3.0"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "jquery-rails"
gem "omniauth-github"
gem 'omniauth-gitlab'
gem 'omniauth-twitter'
# gem "redis", "~> 3.0"
# gem "bcrypt", "~> 3.1.7"

group :development, :test do
  gem "capybara"
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "launchy", require: false
  gem "pry-rails"
  gem "rspec-rails", "~> 3.5"
  gem "shoulda"
  gem "valid_attribute"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :production do
  gem "rails_12factor"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
