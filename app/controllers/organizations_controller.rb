class OrganizationsController < ApplicationController
  before_action :authenticate_user!
  def show
    if params[:id]
      @org = Organization.includes(:announcements, :users).find(params[:id])
    else
      @org = Organization.includes(:announcements, :users).find(current_user.organization.id)
    end
    @announcements = @org.announcements
    @users = @org.users
    @starred = current_user.starred
    @mentees = @users.where(role: 'Mentee') - @starred
    @mentors = @users.where(role: 'Mentor') - @starred
    @message = Message.new message_params
    @chatroom = @org.chatroom
    @online = @users.where(online: true)
    @invite = Invite.new
  end
  def new
    @org = current_user.organizations.build
  end
  def create
    @org = Organization.new organization_params
    if @org.save
      redirect_to @org
    else
      flash[:error] = "Error, please try again."
      redirect_to :back
    end
  end

  private
    def organization_params
      params.require(:organization).permit(:name, :size, :invite_link, :trial, :about, :renewal_date, :creator_id)
    end
    def message_params
      { :chatroom_id => @org.chatroom.id, :user_id => current_user.id }
    end
end
