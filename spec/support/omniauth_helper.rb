module OmniAuthHelper
  def sign_in(user)
    session[:user_id] = user.id
  end

  def mock_omniauth(user, provider)
    auth_hash = {
      provider: provider,
      uid: user.uid,
      info: {
        email: user.email,
        name: user.name,
        image: user.avatar_url
      }
    }

    OmniAuth.config.add_mock(provider, auth_hash)
  end
end
