class RemoveLastNameFromSharers < ActiveRecord::Migration
  def up
    remove_column :sharers, :last_name
  end

  def down
    add_column :sharers, :last_name, :string
  end
end
