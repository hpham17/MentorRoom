class Users::SessionsController < Devise::SessionsController
  before_action :authenticate_user!

  def index
    if current_user.role == "Mentee"
      @users = User.all.order(:id).where(:role => "Mentor")
    else
    end
  end
end
