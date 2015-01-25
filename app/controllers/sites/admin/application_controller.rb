class Sites::Admin::ApplicationController < ApplicationController
  before_action :set_organization
  layout 'sites/admin'

  protected

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end
end
