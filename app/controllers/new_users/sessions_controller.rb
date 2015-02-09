class NewUsers::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
  def after_sign_in_path_for(copasser)
    if session[:organization_id].nil?
      return root_path
    else
      return sites_root_path(session[:organization_id])
    end
  end

  def after_sign_out_path_for(copasser)
    if !params[:recall].nil?
      return params[:recall]
    end
    return root_path
  end

  
end
