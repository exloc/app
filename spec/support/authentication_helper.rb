module AuthenticationHelper
  def mock_omniauth(user)
    auth_hash = {
      provider: user.provider,
      uid: user.uid,
      info: {
        email: user.email,
        name: user.name,
        image: user.avatar_url
      }
    }

    OmniAuth.config.add_mock(user.provider, auth_hash)
  end
end
