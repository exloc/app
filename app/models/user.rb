class User < ApplicationRecord
  class << self
    def from_omniauth(auth)
      # user = where(uid: auth[:uid], provider: auth[:provider]).first_or_initialize
      case auth[:provider]
      when "github"
        return GitHubUser.new(auth)
      when "gitlab"
        return GitLabUser.new(auth)
      when "twitter"
        return TwitterUser.new(auth)
      end

      user.tap do |user|
        user.name = auth.info.name
        user.nickname = auth.info.nickname
        user.email = auth.info.email
        user.image = auth.info.image
        user.location = auth&.extra&.raw_info&.location
        urls = auth.info.urls
      end
    end
  end

  has_secure_token
  has_many :code_examples

  validates :provider, inclusion: %w(github gitlab twitter)
  validates :uid, presence: true
  validates :role, inclusion: %w(user admin)

  def admin?
    role == "admin"
  end

  def to_s
    nickname || name || email || "user-#{id}"
  end
end
