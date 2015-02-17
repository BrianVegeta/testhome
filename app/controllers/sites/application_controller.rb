class Sites::ApplicationController < ApplicationController
  before_action :set_organization
  layout 'sites/application'

  protected

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

end
