class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params[:roomId]}"
  end

  def speak(data)
     Message.create! text: data['message'], room_id: data['roomId']
  end
end
