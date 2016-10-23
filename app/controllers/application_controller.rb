class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :new_messages?
  def after_sign_in_path_for(resource)
    users_path
  end

  def new_messages?
    count = 0
    current_user.chatrooms.uniq.each do |c|
      count += c.count_new_messages(current_user.id)
    end
    count > 0 ? count : false
  end

end
