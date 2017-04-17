# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatroomsChannel < ApplicationCable::Channel
  def subscribed
    if !params['first_id']
      stream_from "chatrooms_#{params['chatroom_id']}_channel"
    else
      if current_user.id == params['first_id']
        stream_from "chatrooms_#{params['first_id']}_channel"
      else
        stream_from "chatrooms_#{params['second_id']}_channel"
      end
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    message = current_user.messages.build(content: data['message'], chatroom_id: data['chatroom_id'])
    message.current_user = current_user.id
    message.other_user = data['other_id']
    message.save!
  end
end
