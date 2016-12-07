class EventsController < ApplicationController
  before_action :authenticate_user!
  def index
    @events = Event.all
    respond_to do |format|
      format.json { render json: @events }
    end
  end

  def create
    @event = Event.new event_params
    @event.user_id = current_user.id
    if @event.save
      flash[:notice] = "Event saved."
      redirect_to current_user
    else
      flash[:danger] = "Failed to save."
      redirect_to :back
    end
  end

  private
  def event_params
    params.require(:event).permit(:start, :end, :title)
  end
end
