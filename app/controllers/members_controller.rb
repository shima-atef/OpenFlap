class MembersController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    user = User.find(params[:user_id])

    if @group.users.exists?(user.id)
      redirect_to @group, notice: 'Member already exists in this group.'
    else
      @group.users << user
      redirect_to @group, notice: 'Member was successfully added.'
    end
  end

  def destroy
    @member = Member.find(params[:id])
    @group = @member.group
    @member.destroy
    redirect_to @group, notice: 'Member was successfully removed.'
  end
end
