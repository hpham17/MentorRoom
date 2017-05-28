class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, only: [:create]
  before_filter :configure_account_update_params, only: [:update]

  def new
    @token = params[:invite_token]
    super
  end

  def create
    @token = params[:invite_token]
    build_resource(sign_up_params)
    if @token != nil
       org_id = Invite.find_by_token(@token).organization_id #find the org attached to the invite
       OrganizationUser.create!(:organization_id => org_id, :user_id => resource.id) #add this user to the org as a member
    end
    
    resource.save
    
    # if not resource.save
    #   render 'users/finish_signup'
    # end

    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end

  end

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
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role, :invite_token])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:id, :name, :skill_list, :help_list, :picture, profile_attributes: [:user_id, :role, :bio, :linkedin, :location, :school, {:degrees => []}, :gradyear, :sports, :languages, :twitter, :website, :hobbies, {:ethnicity => []}, :clubs, :major, :company, :sector, :aspirations, {:identity => []}]])
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
