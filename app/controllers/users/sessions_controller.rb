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
  def tag
    if params["skill"]
      @skill = params["skill"]
      if Tag.is_skill?(@skill) && !current_user.skill_list.include?(@skill)
        current_user.skill_list.add(@skill)
        current_user.save
        flash[:notice] = "Skill saved."
        render html: "<div class='chip'>
          #{@skill}
          <i class='close material-icons'>close</i>
        </div>".html_safe
      end
    else
      @help = params["help"]
      if Tag.is_help?(@help) && !current_user.help_list.include?(@help)
        current_user.help_list.add(@help)
        current_user.save
        flash[:notice] = "Help saved."
        render html: "<div class='chip'>
          #{@help}
          <i class='close material-icons'>close</i>
        </div>".html_safe
      end
    end
  end

  def destroy_tag
    if params["skill"]
      @skill = params["skill"]
      current_user.skill_list.remove(@skill.strip)
    else
      @help = params["help"]
      current_user.help_list.remove(@help.strip)
    end
    current_user.save
    head :ok
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
