class MentorshipsController < ApplicationController
  before_action :authenticate_user!
  def create
    @mentorship = Mentorship.new mentorship_params
    @mentorship.user_id = current_user.id
    if @mentorship.save
      flash[:notice] = "Mentor requested."
    else
      flash[:notice] = "Unable to add mentor."
    end
    redirect_to users_path
  end

  def update
    params.permit(:id)
    m = Mentorship.find(params[:id])
    m.update_attributes(accepted: true)
    redirect_to mentor_path
  end

  private
  def mentorship_params
    params.permit(:mentor_id)
  end

end
