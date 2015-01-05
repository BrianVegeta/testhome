class NewUser < ActiveRecord::Base
	belongs_to :user

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :gplus, :google_oauth2]

	def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    user.email = auth.info.email
	    user.password = Devise.friendly_token[0,20]
	    user.name = auth.info.name   # assuming the user model has a name
	    user.image = auth.info.image # assuming the user model has an image
	  end
	end

	def email_required?
	  false
	end

	def email_changed?
	  false
	end

	def is_facebook?
		return true if self.provider === 'facebook'
	end

	def link_to_social?
		return true unless self.user_id.nil?
	end

	def is_global_admin?
		self.admin_level === 1
	end
end
