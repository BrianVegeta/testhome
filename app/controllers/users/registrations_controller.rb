class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]
  before_filter :set_organization, if: :is_organization?
  before_filter :set_site_layout
  # layout 'sites/application', if: :is_organization?

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation)
    end
  end


  # You can put the params you want to permit in the empty array.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    if is_organization?
      set_organ_member(resource, params[:organization_id])
      return sites_root_path(params[:organization_id])
    else
      root_path
    end
    # super(resource)
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

  def set_organ_member(resource, organization_id)
    member = OrganizationMember.where(user_id: resource.id, organization_id: organization_id).first_or_create
  end
end
