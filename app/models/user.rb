class User < ActiveRecord::Base
	has_one :new_user
  # has_many :organization_member

  # attr_accessor :email_confirmation
  attr_accessor :login_or_email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :encryptable, 
         :omniauthable,
         :encryptor => :restful_authentication_sha1,
         :omniauth_providers => [:facebook, :gplus],
         authentication_keys: [:login_or_email]

  # validates_presence_of :login

  # validates
  # validates :login, uniqueness: true
  # validates :email, confirmation: true, on: :create

  # callback
  before_create :set_last_login_at

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    matchEmail = Devise.email_regexp.match(conditions[:login_or_email])
    
    if matchEmail
      where(email: conditions[:login_or_email]).first
    else
      where(login: conditions[:login_or_email]).first
    end
    
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      user.skip_confirmation!
    end

  end

  def email_required?
    true
  end

  def new_user_linked?
  	return true unless NewUser.where(user_id: self.id).count == 0
  end

  def new_user
  	NewUser.where(user_id: self.id).first
  end

  def is_admin?
  	self.level === 3
  end

  def is_global_admin?
    self.level === 3
  end

  def is_admin?(organization_id)
    OrganizationAuthorization.where(user_id: self.id, organization_id: organization_id).first || self.is_global_admin?
  end

  private
    def set_last_login_at
      self.last_login_at = Time.now
    end
end
