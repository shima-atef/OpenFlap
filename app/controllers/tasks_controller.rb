class TasksController < ApplicationController
    def create
      @group = Group.find(params[:group_id])
      @task = @group.tasks.build(task_params)
  
      if @task.save
        redirect_to @group, notice: 'Task added successfully.'
      else
        render 'groups/show'
      end
    end
  
    private
  
    def task_params
      params.require(:task).permit(:exercise_id)
    end
  end
  