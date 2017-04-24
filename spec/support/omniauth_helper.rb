module OmniAuthHelper
  def sign_in(user)
    session[:user_id] = user.id
  end

  def mock_omniauth(user, provider)
    auth_hash = {
      provider: provider,
      uid: user.uid,
      info: {
        name: user.name,
        nickname: user.nickname,
        email: user.email,
        image: user.image,
        location: user.location,
        urls: user.urls
      }
    }

    OmniAuth.config.add_mock(provider, auth_hash)
  end
end
