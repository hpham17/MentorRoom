class OrganizationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @orgs = Organization.all
  end
  def show
    if params[:id]
      @org = Organization.includes(:announcements, :users).find(params[:id])
      @announcements = @org.announcements
      @users = @org.users
      @chatroom = @org.chatroom
      @starred = current_user.starred
      @mentees = @users.where(role: 'Mentee') - @starred
      @mentors = @users.where(role: 'Mentor') - @starred
      @message = Message.new message_params
      @online = @users.where(online: true)
      @invite = Invite.new
    else
      if !current_user.organizations.empty?
        @orgs = current_user.organizations
      else
        redirect_to action: 'index'
      end
    end
  end
  def new
    @org = current_user.organizations.build
  end
  def create
    @org = Organization.new organization_params
    if @org.save
      OrganizationUser.create! organization_id: @org.id, user_id: @org.creator_id
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
