class Sites::ApplicationController < ApplicationController
  before_action :set_organization
  
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

end
