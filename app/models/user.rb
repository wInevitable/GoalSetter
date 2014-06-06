class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: {minimum: 6, allow_nil: true, message: "must be at least 6 characters"}
  validates :username, uniqueness: true
  
  before_validation do
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end
  
  def self.find_by_credentials(username, password)
    user = find_by(username: username)
    user.try(:is_password?, password) ? user : nil
  end

  
  def password
    @password
  end
  
  def password=(value)
    self.password_digest = BCrypt::Password.create(value)
    @password = value
  end
  
  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    save!
    session_token
  end
  
  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end
end
