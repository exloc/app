class GitHubUser < User
  def initialize(auth)
    @auth = auth
    user.name = auth.info.name
    user.nickname = auth.info.nickname
    user.email = auth.info.email
    user.image = auth.info.image
    user.location = auth&.extra&.raw_info&.location
    user.urls = auth.info.urls
  end

  private

  def user
    @_user ||= where(uid: @auth[:uid], provider: @auth[:provider]).first_or_initialize
  end

  def user_hash

  end
end
