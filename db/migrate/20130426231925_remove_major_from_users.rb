class RemoveMajorFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :major
  end

  def down
    add_column :users, :major, :string
  end
end
