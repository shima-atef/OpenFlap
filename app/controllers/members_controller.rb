class MembersController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @member = @group.members.build(user_id: params[:user_id])
    if @member.save
      redirect_to @group, notice: 'Member was successfully added.'
    else
      redirect_to @group, alert: 'Failed to add member.'
    end
  end

  def destroy
    @member = Member.find(params[:id])
    @group = @member.group
    @member.destroy
    redirect_to @group, notice: 'Member was successfully removed.'
  end
end
