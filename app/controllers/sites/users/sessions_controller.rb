class Sites::Users::SessionsController < Devise::SessionsController
  layout 'sites/application'
  before_filter :set_organization
  # before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  def destroy
    # raise Devise.sign_out_all_scopes.inspect
    # raise resource_name.inspect
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

  def after_sign_out_path_for(resource_or_scope)
    if session['custom.devise.recall']
      session['custom.devise.recall']
    else
      root_path
    end
  end

  protected
  def set_organization
    @organization = Organization.find(params[:organization_id])
  end
end
