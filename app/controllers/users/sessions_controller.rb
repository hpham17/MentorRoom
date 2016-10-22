class Users::SessionsController < Devise::SessionsController
  before_action :authenticate_user!

  def index
    @users = User.all.order(:id).where(:role => "Mentor")
  end
end
