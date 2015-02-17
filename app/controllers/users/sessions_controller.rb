class Users::SessionsController < Devise::SessionsController
  before_filter :set_organization, if: :is_organization?
  before_filter :set_site_layout
  # layout 'sites/application', if: :is_organization?
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    yield resource if block_given?
    respond_with(resource, serialize_options(resource))
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    # signed_out = sign_out(resource_name)
    set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
    yield if block_given?
    respond_to_on_destroy
  end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
  def configure_sign_in_params
    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(:login_or_email, :password, :remember_me)
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if is_organization?
      sites_root_path(params[:organization_id])
    else
      root_path
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    if is_organization?
      sites_root_path(params[:organization_id])
    else
      root_path
    end
  end

  protected

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
