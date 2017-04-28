class Authentication
  attr_reader :auth, :provider

  def initialize(auth)
    @auth = auth
  end

  def user
    result = User.where(uid: auth[:uid], provider: auth[:provider]).first_or_initialize
    result.assign_attributes(user_attributes)
    result
  end

  def provider
    auth[:provider]
  end

  def user_attributes
    case provider
    when "github"
      return GitHub::User.new(auth).to_user_attributes
    when "gitlab"
      return GitLab::User.new(auth).to_user_attributes
    when "twitter"
      return Twitter::User.new(auth).to_user_attributes
    else
      raise "Authentication provider not registered: #{provider}"
    end
  end
end
