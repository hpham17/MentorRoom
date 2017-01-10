class FlashSessionsController < ApplicationController
  def index
    @sessions = FlashSession.all
  end
  def create
    @session = FlashSession.new flash_params
    if @session.save
      redirect_to current_user
    else
      redirect_to :back
    end
  end
  def update
    @session = FlashSession.find(params[:id])
    if @session.update_attributes(:accepted => true)
      flash[:notice] = "Flash session claimed."
      FlashSessionJob.perform_later(current_user.id, @session.user_id)
      redirect_to @current_user
    else
      flash[:error] = "Error"
      redirect_to 'flash_sessions#index'
    end
  end

  private
  def flash_params
    params.require(:flash_session).permit(:date, :user_id, :agent_id, :description)
  end
end
