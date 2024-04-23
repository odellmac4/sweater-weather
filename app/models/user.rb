class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true

  has_secure_password

  def set_api_key
    self.api_key = SecureRandom.hex(32)
    save!
  end
end
