class AddGroupIdToMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :members, :group_id, :integer
  end
end
