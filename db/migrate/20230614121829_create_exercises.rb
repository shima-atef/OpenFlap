class CreateExercises < ActiveRecord::Migration[7.0]
  def change
    create_table :exercises do |t|
      t.integer :user_id
      t.string :title
      t.string :exercise_type

      t.timestamps
    end
  end
end
