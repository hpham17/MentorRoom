class StarsController < ApplicationController
  respond_to :js

  def star
    @user = current_user
    @starred = User.find(params[:starred_id])
    @user.star!(@starred)
  end

  def unstar
    @user = current_user
    @star = @user.stars.find_by_starred_id(params[:starred_id])
    @starred = User.find(params[:starred_id])
    @star.destroy
  end
end
