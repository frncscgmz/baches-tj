class User < ActiveRecord::Base
   # Include default devise modules. Others available are:
   # :confirmable, :lockable, :timeoutable and :omniauthable
   devise :database_authenticatable, :registerable,:omniauthable,
      :recoverable, :rememberable, :trackable, :validatable
   has_many :authentications, :dependent => :destroy
   has_many :bache, dependent: :destroy

   before_save { self.email = email.downcase }
   #before_create :create_remember_token

   validates :name, presence: true, length: { maximum: 50 }
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
   validates :email, presence: true,
      format: { with: VALID_EMAIL_REGEX },
      uniqueness: { case_sensitive: false }
   #has_secure_password
   #validates :password, length: { minimum: 6 }

   def apply_omniauth(omni)
      authentications.build(:provider => omni['provider'],
         :uid => omni['uid'],
         :token => omni['credentials'].token,
         :token_secret => omni['credentials'].secret)
   end

   def self.from_omniauth(auth)
      where(auth.slice(:provider, :uid)).first_or_create do |user|
         user.provider = auth.provider
         user.uid = auth.uid
      end
   end

   def self.new_with_session(params, session)
      if session["devise.user_attributes"]
         new(session["devise.user_attributes"], without_protection: true) do |user|
            user.attributes = params
            user.valid?
         end
      else
         super
      end
   end

   def password_required?
      (authentications.empty? || !password.blank?) && super
   end

   # Deprecado?
   def User.new_remember_token
      SecureRandom.urlsafe_base64
   end

   # Deprecado?
   def User.encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
   end

   private

   # Deprecado?
   def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
   end
end
