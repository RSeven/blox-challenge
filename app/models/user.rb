class User < ApplicationRecord
  devise :database_authenticatable, :validatable

  enum role: [:user, :moderator]

  has_many :events, dependent: :destroy
end
