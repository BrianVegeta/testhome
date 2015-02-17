class HomeController < ApplicationController
	# @id = 'g1234'
	# before_action :authenticate_user!
	def index
		# text = "#{yield authenticate_user!}"
		# raise text.inspect
		opts = {}
		opts[:scope] = :user
		opts[:test] = :test
		# raise user_session.inspect
		# raise warden.authenticate!(opts).inspect
		# sign_in(:user, User.find(2))
		# sign_in(:g1234, OrganizationAuth.find(35), {bypass: true})
		# sign_in(:g1234, User.find(2), {bypass: true})
		# sign_out(:g1234)
		
		# warden.set_user(OrganizationAuth.find(35), {scope: :g1234})
	end

	def test
		session['test.test'] = '123'
	end
end
