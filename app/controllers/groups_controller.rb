class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to @group, notice: 'Group was successfully created.'
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
    @members = @group.members
  end
  

  def group_tasks
    @group = Group.find(params[:id])
    @task = @group.tasks.build(task_params)

    if @task.save
      redirect_to @group, notice: 'Exercise added successfully.'
    else
      render :show
    end
  end

  def dashboard
    @group = Group.find(params[:id])
    @members = @group.members
    @exercises = @group.exercises
  end

  def waitingList
    @group = Group.find(params[:id])
  end 

  # POST /groups/1/join
  def join

     @group = Group.find(params[:id])
     if @group.public
       if @group.members.include?(current_user)
         redirect_to @group, alert: "You are already a member of this group."
       else
         member = Member.new(user: current_user, group: @group)
         if member.save
         redirect_to @group, notice: "You have joined the group!"
       else
   
       redirect_to group_path(@group)
     end
   end 
  else 
    waitingList = WaitingList.new(user: current_user, group: @group)
   waitingList.save
end

  end 

 

  def user_group
    user_id = current_user.id

    @groups = Group.joins(:members).where(members: { user_id: user_id })
                  .or(Group.where(user_id: user_id))
                  .distinct
  end 

  private

  def group_params
    params.require(:group).permit(:title, :description, :user_id, :public, task: [:exercise_id])
  end
end
