class Users::PasswordsController < Devise::PasswordsController
  before_filter :set_organization, if: :is_organization?
  before_filter :set_site_layout
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end
  def create
    user = User.where(email: resource_params[:email]).first
    user.confirm_organization_id = nil
    user.confirm_organization_id = params[:organization_id] if is_organization?
    user.save
    
    super
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  #PUT /resource/password
  def update
    super
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
  protected

  def after_resetting_password_path_for(resource)
    if is_organization?
      sites_root_path(params[:organization_id])
    else
      root_path
    end
  end

  def after_sending_reset_password_instructions_path_for(resource_name)
    if is_organization?
      sites_root_path(params[:organization_id])
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
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
