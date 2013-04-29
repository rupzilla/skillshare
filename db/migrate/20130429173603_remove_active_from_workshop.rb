class RemoveActiveFromWorkshop < ActiveRecord::Migration
  def up
    remove_column :workshops, :active
  end

  def down
    add_column :workshops, :active, :boolean
  end
end
