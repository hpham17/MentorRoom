class Users::SessionsController < Devise::SessionsController
  before_action :authenticate_user!

  def index
    @users = User.all.order(:id).where(:role => "Mentor")
  end
  def admin
    @users = User.all.order(:id)
  end
  def mentor
    @requests = Mentorship.where(mentor_id: current_user.id, accepted: false)
    @mentees = extract_mentees(@requests)
  end

  private
  def extract_mentees(association)
    mentees = []
    association.each do |x|
      mentees << [User.find(x.user_id), x.id]
    end
    mentees
  end
end
