class Social::TransferSocialLoginController < ApplicationController
	skip_before_action :transfer_social_login, :only => :do_transfer

	def do_transfer
		session[:loginId] = current_user.id
		redirect_to new_user_omniauth_authorize_path(params[:provider])
	end
end