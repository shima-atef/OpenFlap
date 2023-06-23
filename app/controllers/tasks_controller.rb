class TasksController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
    @task = Task.new

    respond_to do |format|
      format.html # Render the HTML template
      format.js   # Render a JavaScript response (for AJAX requests)
    end
  end

  def create
    @group = Group.find(params[:group_id])
    exercise_ids = params[:task][:exercise_ids]

    if exercise_ids.blank?
      redirect_to @group, alert: 'Please enter at least one exercise ID.'
      return
    end

    errors = []
    exercise_ids.split("\n").map(&:strip).each do |exercise_id|
      next if exercise_id.blank?

      task = Task.new(exercise_id: exercise_id, group: @group)
      if @group.exercises.exists?(exercise_id)
        errors << "Exercise #{exercise_id} already exists in this group."
      elsif task.save
        @group.tasks << task
      else
        errors << "Error adding Exercise #{exercise_id}."
      end
    end

    if errors.empty?
      redirect_to @group, notice: 'Tasks added successfully.'
    else
      redirect_to @group, alert: errors.join('<br>').html_safe
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @group = @task.group
    @task.destroy
    redirect_to @group, notice: 'Task was successfully removed.'
  end

  private

  def task_params
    params.permit(:exercise_id).merge(group_id: params[:group_id])
  end
end
