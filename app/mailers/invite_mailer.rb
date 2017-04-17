class InviteMailer < ApplicationMailer

  def new_user_invite(invite, org_name, link)
    @email = invite.email
    @link = link
    @org_name = org_name
    mail(to: @email, subject: 'Invitation: MentorRoom')
  end
end
