class AuthenticationService
  attr_reader :auth, :provider

  def initialize(auth)
    @auth = auth
  end

  def user
    result = User.where(uid: auth[:uid], provider: auth[:provider]).first_or_initialize
    result.assign_attributes(user_hash)
    result
  end

  def provider
    auth[:provider]
  end

  def user_hash
    case provider
    when "github"
      return GitHub::User.new(auth).to_hash
    when "gitlab"
      return GitLab::User.new(auth).to_hash
    when "twitter"
      return Twitter::User.new(auth).to_hash
    else
      raise "Authentication provider not registered: #{provider}"
    end
  end
end
