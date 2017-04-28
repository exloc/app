class User < ApplicationRecord
  class << self
    def from_param(nickname_provider)
      n, p = nickname_provider.split("-", 2)
      find_by!(nickname: n, provider: p)
    end
  end

  has_secure_token
  has_many :code_examples

  validates :provider, inclusion: %w(github gitlab twitter)
  validates :uid, presence: true
  validates :role, inclusion: %w(user admin)

  def admin?
    role == "admin"
  end

  def new_account?
    created_at == updated_at
  end

  def to_param
    "#{nickname}-#{provider}"
  end

  def to_s
    if nickname.present? && provider.present?
      return "#{nickname}/#{provider}"
    else
      return "user-#{id}"
    end
  end
end
