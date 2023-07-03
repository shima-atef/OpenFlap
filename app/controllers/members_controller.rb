class MembersController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
    @member = Member.new
  end

  def create
    @group = Group.find(params[:group_id])
    member_emails = params[:member][:emails].split("\n").map(&:strip)
    
    if member_emails.blank?
      redirect_to @group, alert: 'Please enter at least one member email.'
      return
    end
    member_emails = params[:member][:emails].split("\n").map(&:strip)

    member_emails.each do |email|
  
      next if email.blank?

      user = User.find_by(email: email)
      # Remove users from waiting list
   if !user.nil?
    waiting_list_entries = @group.waitingList.where(user_id:  user.id)
    waiting_list_entries.destroy_all
   end 
      next if user.nil?

      unless @group.members.exists?(user_id: user.id)
        @group.members.create(user: user)
      end
    end

    
    redirect_to group_dashboard_path(@group)
  end
  
end



