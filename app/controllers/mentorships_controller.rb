class MentorshipsController < ApplicationController
  def create
    @friendship = current_user.mentorships.build(:mentor_id => params[:mentor_id])
    if @friendship.save
      flash[:notice] = "Added friend."
    else
      flash[:notice] = "Unable to add friend."
    end
    redirect_to users_path
  end
end
