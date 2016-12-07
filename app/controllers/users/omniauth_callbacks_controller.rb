class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end
  def linkedin
    omniauth_hash = env["omniauth.auth"]
    current_user.create_linkedin_connection(
      :token  => omniauth_hash["extra"]["access_token"].token,
      :secret => omniauth_hash["extra"]["access_token"].secret,
      :uid    => omniauth_hash["uid"]
    )
    redirect_to root_path, :notice => "You've successfully connected your LinkedIn account."
  end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
