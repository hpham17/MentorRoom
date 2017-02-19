class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  def index
    @chatrooms = current_user.chatrooms.uniq.reverse
  end

  def new
    @chatroom = room_exist?
    if @chatroom
      redirect_to @chatroom
    else
      create_chatroom
    end
  end

  def create
    create_chatroom
  end


  def show
    @chatroom = Chatroom.includes(:messages).find_by(slug: params[:slug])
    @message = Message.new
  end

  private
  def room_exist?
    Chatroom.find_by_topic current_user.id.to_s + "_to_" + params[:id].to_s
  end

  def chatroom_params
    {topic: current_user.id.to_s + "_to_" + params[:id].to_s }
  end

  def create_chatroom
    @chatroom = Chatroom.new chatroom_params
    if @chatroom.save
      @message1 = Message.new user_id: current_user.id, content: " has joined the room.", chatroom_id: @chatroom.id
      @message2 = Message.new user_id: params[:id], content: " has joined the room.", chatroom_id: @chatroom.id
      @chatroom.messages << @message1
      @chatroom.messages << @message2
      @chatroom.save
      respond_to do |format|
        format.html { redirect_to @chatroom }
        format.js
      end
    else
      respond_to do |format|
        flash[:notice] = {error: ["a chatroom with this topic already exists"]}
        format.html { redirect_to users_path }
        format.js { render template: 'chatrooms/chatroom_error.js.erb'}
      end
    end
  end

end
