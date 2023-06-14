class CreateSubmissions < ActiveRecord::Migration[7.0]
  def change
    create_table :submissions do |t|
      t.integer :user_id
      t.integer :exercise_id
      t.float :grade
      t.text :solution

      t.timestamps
    end
  end
end
