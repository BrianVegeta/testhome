class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      
      if @user.errors.messages[:email]
        set_flash_message(:social, :failure, :kind => "Facebook", reason: '電子信箱已經註冊。')  
      end
      
      redirect_to new_user_registration_url
    end
  end

  def gplus
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Google+") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]

      if @user.errors.messages[:email]
        set_flash_message(:social, :failure, :kind => "Google+", reason: '電子信箱已經註冊。')
      end
      redirect_to new_user_registration_url
    end
  end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when omniauth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
  def after_sign_in_path_for(resource_or_scope)
    
    if session['custom.devise.recallpath']
      session['custom.devise.recallpath']
    else
      root_path
    end
  end

end
