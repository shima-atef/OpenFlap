class TasksController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @task = @group.tasks.build(task_params)

    if @group.exercises.exists?(task_params[:exercise_id])
      redirect_to @group, notice: 'Exercise already exists in this group.'
    elsif @task.save
      redirect_to @group, notice: 'Exercise added successfully.'
    else
      render 'groups/show'
    end
  end

  private

  def task_params
    params.permit(:exercise_id).merge(group_id: params[:group_id])
  end
end
