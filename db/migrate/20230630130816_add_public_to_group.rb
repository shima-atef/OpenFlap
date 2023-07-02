class AddPublicToGroup < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :public, :boolean
  end
end
