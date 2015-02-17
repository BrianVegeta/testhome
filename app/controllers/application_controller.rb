class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_recall_url, if: :allow_set_recall_url?

  # before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :transfer_social_login
  # before_action :set_current_organization, unless: :devise_controller?

  protected
  
  def set_recall_url
    session['custom.devise.recallpath'] = request.path
  end

  def allow_set_recall_url?
    return false if devise_controller?
    return true
  end

  # def configure_permitted_parameters
  # 	devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :password, :remember_me) }
  # end

  # def transfer_social_login
  # 	if !session[:loginId].nil? && new_user_signed_in?
  # 		current_new_user.user_id = session[:loginId]
  # 		current_new_user.admin_level = 1 if User.find(current_new_user.user_id).level == 3
  # 		current_new_user.save
  # 		session.delete(:loginId)
  # 		sign_out :user
  # 	end
  # end

  # def set_current_organization
  #   # raise 'session'.inspect
  #   session[:organization_id] = params[:organization_id]
  #   # raise session[:organization_id].inspect
  # end
end
