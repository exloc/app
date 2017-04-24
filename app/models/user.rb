class User < ApplicationRecord
  class << self
    def from_omniauth(auth)
      case auth[:provider]
      when "github"
        return GitHubUser.new(auth).to_user
      when "gitlab"
        return GitLabUser.new(auth).to_user
      when "twitter"
        return TwitterUser.new(auth).to_user
      else
        raise "Authentication provider not registered: #{auth[:provider]}."
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

  def new_account?
    created_at == updated_at
  end

  def to_s
    nickname || name || email || "user-#{id}"
  end
end
