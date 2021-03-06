################################################################################
# Model:  User
#
# Purpose:
#
# User attributes:
#   role              - User's role: enum
#   last_name         - Last name:   string, not NULL
#   first_name        - First name:  string, not NULL
#   email             - email:       string,  not NULL, unique
#   status            - status:      enum { active (0) | archived (1) }, default: 0
#
#  24.11.2015 ZT
################################################################################
class User < ActiveRecord::Base

  before_save {self.email.downcase!}

  enum role:   %w(manager admin sysadmin)
  enum status: %w(active archived)

  validates :last_name,  presence: true
  validates :first_name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  # Returns an User full name
  def full_name
    "#{last_name} #{first_name}"
  end

  private

    # Returns a random token
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    # Returns a new token.
    def User.new_token
      SecureRandom.urlsafe_base64
    end

    # Remembers a user in the database to apply him/her in persistent sessions
    def remember
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
    end

    # Returns true if the given token matches the digest.
    def authenticated?(remember_token)
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
end
