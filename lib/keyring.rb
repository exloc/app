<<-MARKDOWN

# Keyring

A module for managing environmental variables.

## Motivation

Integration of a new service will leave other developers with a breaking build.
Inevitably, someone will miss the IRC announcement to generate and add the
YahooCode API keys to their local dev environment. Instead of blowing up, the
codebase should return a clear and actionable message.

## Solution

* Maintain a list of `KEYS` your application needs for external integrations.
* run `.check` early in your application (after `dotenv.load`).
  - alert if ENV keys don't match KEYS (msg: update .env)
  - alert if .env keys don't match KEYS (msg: update KEYS)
* `.export` a new .env.example file

MARKDOWN

module Keyring
  KEYS = %w(
    PORT
    GITHUB_KEY
    GITHUB_SECRET
    GITLAB_KEY
    GITLAB_SECRET
    TWITTER_KEY
    TWITTER_SECRET
  )

  def self.check
    KEYS.each do |key|
      raise "ENV['#{key}'] not set!" unless ENV[key].present?
    end

    dotenv_file = Rails.root.join(".env")
    keys = File.readlines(dotenv_file).map { |k| k.split("=").first }
    keys.each do |key|
      warn "Please document '#{key}' in Keyring::KEYS" unless KEYS.include?(key)
    end
  end

  def self.export(filename = Rails.root.join(".env.example"))
    File.open(filename, "w") do |file|
      KEYS.each { |key| file.puts "#{key}=\"\"" }
    end
  end
end
