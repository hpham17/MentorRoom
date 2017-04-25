class InviteMailer < ApplicationMailer
  def new_user_invite(invite, org_name, link)
    @email = invite.email
    @link = link
    @org_name = org_name
    mail(to: @email, subject: 'Invitation: MentorRoom')
  end
  def existing_user_invite(invite)
    @email = invite.email
    @org_name = Organization.find(invite.organization_id).name
    mail(to: @email, subject: 'New Organization Invitation')
  end
end
