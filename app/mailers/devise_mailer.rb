class DeviseMailer < Devise::Mailer

	def confirmation_instructions(record, token, opts={})
		opts[:subject] = "吉便屋-IsHome 驗證信"
		opts[:template_path] = 'users/mailer'
    super
  end

  def reset_password_instructions(record, token, opts={})
  	opts[:subject] = "吉便屋-IsHome 密碼變更信"
		opts[:template_path] = 'users/mailer'
  	super
  end
end