class GroupsController < ApplicationController
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

  private

  def group_params
    params.require(:group).permit(:title, :description, :user_id, task: [:exercise_id])
  end
end
