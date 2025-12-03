class User < ApplicationRecord
#securing password storage
#using bcrypt
  has_secure_password

# The associations
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

# Validations
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, if: -> { password.present? }
  validates :display_name, presence: true
  validates :role, inclusion: { in: %w[user admin] }

# preventing mass assignment of roles
# only an admin can modify modify roles
  def promote_to_admin!
    update(role: "admin")
  end

# securing authentication
# preventing SQL injection
  def self.authenticate(email, password)
    user = User.find_by(email: email)
    return nil unless user
    user.authenticate(password) ? user : nil
  end
end

