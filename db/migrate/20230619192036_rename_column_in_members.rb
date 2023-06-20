class RenameColumnInMembers < ActiveRecord::Migration[7.0]
  def change
    remove_column :members, :groub_id, :integer
  end
end
