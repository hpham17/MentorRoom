class Users::RegistrationsController < Devise::RegistrationsController
  def create
    @user = User.new user_params
    if @user.save
      flash[:notice] = "Sign up successful."
      redirect_to '/users'
    else
      flash[:danger] = "Failed to sign up."
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
