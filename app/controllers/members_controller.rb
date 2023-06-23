class MembersController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
    @member = Member.new
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
      redirect_to @group, notice: 'Exercises added successfully.'
    else
      redirect_to @group, alert: errors.join('<br>').html_safe
    end
  end

  if errors.empty?
    redirect_to @group, notice: 'Exercises added successfully.'
  else
    redirect_to @group, alert: errors.join('<br>').html_safe
  end
  def destroy
    @member = Member.find(params[:id])
    @group = @member.group
    @member.destroy
    redirect_to @group, notice: 'Member was successfully removed.'
  end
end
