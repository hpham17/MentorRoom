class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :ensure_signup_complete, only: [:new, :create, :update, :destroy]
  helper_method :new_messages?

  def after_sign_in_path_for(user)
    if user.is? :Mentee
      users_path
    elsif user.is? :Mentor
      mentor_path
    else
      admin_path
    end
  end

  def new_messages?
    count = 0
    current_user.chatrooms.uniq.each do |c|
      count += c.count_new_messages(current_user.id)
    end
    count > 0 ? count : false
  end

  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

end
