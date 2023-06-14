class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.integer :groub_id
      t.integer :exercise_id

      t.timestamps
    end
  end
end
