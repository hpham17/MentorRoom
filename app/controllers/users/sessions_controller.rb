class Users::SessionsController < Devise::SessionsController
  before_action :authenticate_user!

  def index
    @users = User.all.order(:id).where(:role => "Mentor")
    @engineers = User.tagged_with(["Software Engineering", "cool"], :any => true)
    @business = User.tagged_with("Business")
    @sanfran = Profile.where(location: "San Francisco, CA")
    @mentorship = Mentorship.new
  end
  def show
    @user = User.find(params[:id])
    @event = Event.new
  end
  def admin
    @users = User.all.order(:id)
  end
  def mentor
    @requests = Mentorship.where(mentor_id: current_user.id, accepted: false)
    @mentees = extract_mentees(@requests)
  end
  def skill
    @skill = params["chip"]["tag"]
    if Tag.is_skill?(@skill)
      current_user.skill_list.add(@skill)
      current_user.save
      flash[:notice] = "Skill saved."
    else
      flash[:error] = "Not one of the presets."
    end
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end
  def help
    current_user.help_list.add(params["chip"]["tag"])
    current_user.save
    redirect_to user_path(current_user)
  end
  def destroy_skill
    current_user.skill_list.remove(params["chip"]["tag"])
    current_user.save
    redirect_to user_path(current_user)
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
