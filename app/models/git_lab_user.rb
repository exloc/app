class GitLabUser
  def initialize(auth)
    @auth = auth
    user.assign_attributes(user_attributes)
  end

  def to_user
    user
  end

  private

  def user
    @_user ||= User.where(uid: @auth[:uid], provider: @auth[:provider]).first_or_initialize
  end

  def user_attributes
    {
      name: @auth.info.name,
      nickname: @auth.info.username,
      email: @auth.info.email,
      image: @auth.info.image,
      location: @auth&.extra&.raw_info&.location,
      urls: @auth.info.urls
    }
  end
end
