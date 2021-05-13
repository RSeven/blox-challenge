class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, uniqueness: true

  enum role: [:user, :moderator]
end
