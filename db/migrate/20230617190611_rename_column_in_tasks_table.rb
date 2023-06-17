class RenameColumnInTasksTable < ActiveRecord::Migration[7.0]
  def change
    rename_column :Tasks, :groub_id, :group_id
  end
end
