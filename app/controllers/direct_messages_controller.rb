class DirectMessagesController < ApplicationController

  def index
    @convos = current_user.chatrooms
    @senders = current_user.senders
    @receivers = current_user.receivers
  end
  def create
    @dm = DirectMessage.new dm_params
    if !@dm.save
      flash[:danger] = "An error has occurred."
      redirect_to root_path
    end
    @chatroom = Chatroom.new topic: chat_name, direct_message_id: @dm.id
    if @dm.save && @chatroom.save

      redirect_to @chatroom
    else
      flash[:danger] = "An error has occurred."
      redirect_to root_path
    end
  end

  private

  def dm_params
    params[:id] =~ /^(\d)_to_(\d)$/
    return {sender_id: $1, receiver_id: $2}
  end


  def chat_name
    params[:id] =~ /^(\d)_to_(\d)$/
    User.find($1).name + ' to ' + User.find($2).name
  end
end
