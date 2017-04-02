class AttachmentsController < ApplicationController
  def create
    @attachment = Attachment.new attachment_params
    @attachment.user_id = current_user.id
    if @attachment.save
      flash[:notice] = "Success"
    else
      flash[:error] = "Failed: PDFS only"
    end
    redirect_to :back
  end

  private
  def attachment_params
    params.require(:attachment).permit(:url, :type, :user_id)
  end
end
