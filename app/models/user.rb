class User < ActiveRecord::Base
  has_many :orders, dependent: :destroy
  has_many :messages, dependent: :destroy

  before_save { email.downcase! }

  has_secure_password

  before_create :create_remember_token
  validates_presence_of :name
  validates_presence_of :email
  validates :name, length: { maximum: 20 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6 }


  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
