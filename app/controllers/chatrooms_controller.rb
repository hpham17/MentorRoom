class ChatroomsController < ApplicationController

  def index
    @chatrooms = current_user.chatrooms.uniq
  end

  def new
    show_or_new
  end

  def show_or_new
    @chatroom = room_exist?
    if @chatroom
      redirect_to @chatroom
    else
      create
    end
  end

  def create
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


  def show
    @chatroom = Chatroom.find_by(slug: params[:slug])
    @message = Message.new
  end

  private
    def chatroom_params
      {topic: current_user.id.to_s + "_to_" + params[:id].to_s }
    end

    def room_exist?
      current_user.chatrooms.each do |c|
        if c.users.include?(User.find(params[:id]))
          return c
        end
      end
      nil
    end

end
