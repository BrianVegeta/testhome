class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :encryptable, :encryptor => :restful_authentication_sha1, 
         authentication_keys: [:login]

  def email_required?
    false
  end
end
