class InvitesController < ApplicationController
  def new
    @invite = Invite.new
  end
  def create
    emails = params[:invite][:email].split(', ')
    emails.each do |email|
      @invite = Invite.new(invite_params)
      @invite.sender_id = current_user.id
      if @invite.save

        #if the user already exists
        if @invite.recipient != nil

           #send a notification email
           InviteMailer.existing_user_invite(@invite).deliver

           #Add the user to the user group
           OrganizationUser.create(:organization_id => @invite.organization_id, :user_id => @invite.recipient.id)

        else
           InviteMailer.new_user_invite(@invite, @invite.organization.name, new_user_registration_path(:invite_token => @invite.token)).deliver_later
        end
      end
    end
    flash[:notice] = "Invitations sent."
    redirect_to organization_path(@invite.organization_id)
  end

  def invite_params
    params.require(:invite).permit(:organization_id, :email, :token, :sender_id, :recipient_id)
  end
end
