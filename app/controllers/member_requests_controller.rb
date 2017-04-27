class MemberRequestsController < ApplicationController
  def create
    @request = MemberRequest.create member_params
    render json: @request
  end

  private
  def member_params
    params.permit(:user_id, :organization_id)
  end
end
