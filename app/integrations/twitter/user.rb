module Twitter
  class User
    def initialize(auth)
      @auth = auth
    end

    def to_hash
      {
        name: auth.info.name,
        nickname: auth.info.nickname,
        email: auth.info.email,
        image: auth.info.image,
        location: auth.info.location,
        urls: auth.info.urls
      }
    end

    private
    attr_reader :auth
  end
end
