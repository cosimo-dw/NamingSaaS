class User < ActiveRecord::Base
  has_many :orders, dependent: :destroy
  has_many :messages, dependent: :destroy

  before_save { email.downcase! }

  has_secure_password

  before_create :create_remember_token
  validates_presence_of :name, :message => "用户名不能为空！"
  validates_presence_of :email, :message => "登录邮箱不能为空！"
  #validates_presence_of :password, :message => 密码不能为空
  #validates_presence_of :password_confirmation, :message => "密码验证不能为空！"
  validates :name, length: { maximum: 20, :too_long => "用户名至多为二十个字符！"}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX, :message => "登录邮箱格式不正确！"},
                    uniqueness: { case_sensitive: false, :message => "该邮箱已经注册！" }

  validates :password, length: { minimum: 6, :too_short => "密码至少为六个字符！"}


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
