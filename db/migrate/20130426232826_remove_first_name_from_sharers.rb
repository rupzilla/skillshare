class RemoveFirstNameFromSharers < ActiveRecord::Migration
  def up
    remove_column :sharers, :first_name
  end

  def down
    add_column :sharers, :first_name, :string
  end
end
