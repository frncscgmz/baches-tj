class User < ActiveRecord::Base
   # Include default devise modules. Others available are:
   # :confirmable, :lockable, :timeoutable and :omniauthable
   devise :database_authenticatable, :registerable,:omniauthable,
      :recoverable, :rememberable, :trackable, :validatable
   has_many :authentications
   has_many :bache, dependent: :destroy

   before_save { self.email = email.downcase }
   before_create :create_remember_token

   validates :name, presence: true, length: { maximum: 50 }
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
   validates :email, presence: true,
      format: { with: VALID_EMAIL_REGEX },
      uniqueness: { case_sensitive: false }
   has_secure_password
   validates :password, length: { minimum: 6 }

   def apply_omniauth(omni)
      authentications.build(:provider => omni['provider'],
         :uid => omni['uid'],
         :token => omni['credentials'].token,
         :token_secret => omni['credentials'].secret)
   end

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
