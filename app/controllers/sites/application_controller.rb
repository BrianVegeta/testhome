class Sites::ApplicationController < ApplicationController
  before_action :set_organization
  before_action :auth_admin!
  
  layout 'sites/application'

  protected

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def set_organ_member
  	if user_signed_in?
      return if current_user.is_global_admin?
  		OrganizationMember.where(user_id: current_user.id, organization_id: @organization.id).first_or_create

  	end
  end

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
