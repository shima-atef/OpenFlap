class DashboardController < ApplicationController
  def show
    @group = Group.find(params[:group_id])
    @members = @group.members
    @user = current_user
  end

end
