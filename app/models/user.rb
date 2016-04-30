class User < ActiveRecord::Base
  has_secure_password

  has_many :comments

  enum role: [:user, :admin]

  validates :email, presence: true, uniqueness: true, email: true
  validates :password, presence: { on: :create }, confirmation: true,
                       length: { in: 6..32 }, allow_nil: true
  validates :password_confirmation, presence: true, if: -> { password.present? }
end
