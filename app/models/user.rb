class User < ApplicationRecord
  class << self
    def from_omniauth(auth)
      where(uid: auth[:uid], provider: auth[:provider]).first_or_initialize.tap do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.name = auth.info.name
      end
    end

    private
    def admin_params
      {
        email: ENV["ADMIN_EMAIL"],
        password: ENV["ADMIN_PASSWORD"],
        password_confirmation: ENV["ADMIN_PASSWORD"],
        role: "admin",
        name: "Admin"
      }
    end
  end

  validates :provider, inclusion: %w(github)
  validates :uid, presence: true
  validates :role, inclusion: %w(user admin)

  def admin?
    role == "admin"
  end

  def is_new_account?
    created_at == updated_at
  end

  def to_s
    name || email
  end
end
