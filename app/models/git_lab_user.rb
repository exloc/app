module GitLabUser
  def self.from_omniauth(auth)
    @auth = auth
    user = User.where(uid: @auth[:uid], provider: @auth[:provider]).first_or_initialize
    user.assign_attributes(user_attributes)
    return user
  end

  def self.user_attributes
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
