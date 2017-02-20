class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, only: [:create]
  before_filter :configure_account_update_params, only: [:update]

  def edit
     @user = current_user
     @user.build_profile unless @user.profile
  end
  def edit_picture
    @user = current_user
  end
  def update_picture
    current_user.update_attributes :picture => params[:user][:picture]
    redirect_to current_user
  end
  def setup
    @user = current_user
    @profile = current_user.build_profile
  end
  def update
    super
  end


  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:id, :name, :skill_list, :help_list, :picture, profile_attributes: [:user_id, :role, :bio, :linkedin, :location, :school, {:degrees => []}, :gradyear, :sports, :languages, :twitter, :website, :hobbies, :ethnicity, :clubs, :major, :company, :sector]])
  end

  def after_sign_up_path_for(resource)
    if !resource.is?(:Admin)
      '/setup'
    else
      root_path
    end
  end
  def after_update_path_for(resource)
    user_path(resource)
  end
  private
  # def user_params
  #   params.require(:user).permit(:name, :password, :password_confirmation, :current_password, profile_attributes: [:user_id, :role, :bio, :linkedin, :location, :school, :degrees, :gradyear, :sports, :languages, :twitter, :website, :hobbies, :ethnicity, :clubs, :major, :company, :sector])
  # end

end
