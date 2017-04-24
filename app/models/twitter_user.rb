module TwitterUser
  def self.from_omniauth(auth)
    @auth = auth
    user = User.where(uid: @auth[:uid], provider: @auth[:provider]).first_or_initialize
    user.assign_attributes(user_attributes)
    return user
  end

  def self.user_attributes
    {
      name: @auth.info.name,
      nickname: @auth.info.nickname,
      email: @auth.info.email,
      image: @auth.info.image,
      location: @auth.info.location,
      urls: @auth.info.urls
    }
  end
end
