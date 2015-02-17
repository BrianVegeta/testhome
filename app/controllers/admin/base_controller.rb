class Admin::BaseController < ApplicationController
	# before_action :authenticate_user!
	before_action :auth_admin!
  layout 'admin/application'

	protected

  def auth_admin!
  	if user_signed_in?
  		if current_user.is_global_admin?
  			return
  		end
  		redirect_to root_path
  		return
  	end
  	redirect_to new_user_session_path
  end
end