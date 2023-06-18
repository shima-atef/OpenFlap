class AddGroupIdToExercises < ActiveRecord::Migration[7.0]
  def change
    add_reference :exercises, :group, foreign_key: true
  end
end
