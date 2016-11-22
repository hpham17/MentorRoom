class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, only: [:create]
  before_filter :configure_account_update_params, only: [:update]

  def edit
     @user = current_user
     @user.build_profile unless @user.profile
  end
  def setup
    @user = current_user
    @profile = current_user.build_profile
  end
  def update
    current_user.update_attributes user_params
    redirect_to user_path(current_user)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :skill_list, :help_list, profile_attributes: [:user_id, :role, :bio, :linkedin, :location, :school]])
  end

  def after_sign_up_path_for(resource)
    if resource.is? :Mentor
      '/setup'
    else
      users_path
    end
  end
  def after_update_path_for(resource)
    user_path(resource)
  end
  private
  def user_params
    params.require(:user).permit(profile_attributes: [:user_id, :role, :bio, :linkedin, :location, :school])
  end

end
