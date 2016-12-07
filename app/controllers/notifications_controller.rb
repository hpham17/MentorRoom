class NotificationsController < ApplicationController
  before_action :authenticate_user!
  def clear
    a = current_user.notification
    if params[:message_id]
      a.count -= 1
      a.messages.delete(Message.find(params[:message_id]))
    else
      a.count = 0
      a.messages.delete_all
    end
    a.save
    head :ok
  end
end
