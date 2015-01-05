class User < ActiveRecord::Base
	has_one :new_user
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :encryptable, :encryptor => :restful_authentication_sha1, 
         authentication_keys: [:login]

  def email_required?
    false
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
end
