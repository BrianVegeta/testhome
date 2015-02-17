class Users::ConfirmationsController < Devise::ConfirmationsController
  before_filter :set_organization, if: :is_organization?
  before_filter :set_site_layout
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  def create
    user = User.where(email: resource_params[:email]).first
    user.confirm_organization_id = nil
    user.confirm_organization_id = params[:organization_id] if is_organization?
    user.save
    
    super
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super
  # end

  protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
  def after_resending_confirmation_instructions_path_for(resource_name)
    if is_organization?
      sites_root_path(params[:organization_id])
    else
      root_path
    end
  end

  def after_confirmation_path_for(resource_name, resource)
    if is_organization?
      sites_root_path(params[:organization_id])
    else
      root_path
    end
  end

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def is_organization?
    return true if params[:organization_id]
    return false
  end

  def set_site_layout
    if is_organization?
      self.class.layout 'sites/application'
    else
      self.class.layout 'application'
    end
  end
end
