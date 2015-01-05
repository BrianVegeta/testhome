class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :transfer_social_login

  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :password, :remember_me) }
  	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:login, :password, :password_confirmation, :remember_me) }
  end

  def transfer_social_login
  	if !session[:loginId].nil? && new_user_signed_in?
  		current_new_user.user_id = session[:loginId]
  		current_new_user.save
  		session.delete(:loginId)
  		sign_out :user
  	end
  end
end
