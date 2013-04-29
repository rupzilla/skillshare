class RemoveActiveFromUpvotes < ActiveRecord::Migration
  def up
    remove_column :upvotes, :active
  end

  def down
    add_column :upvotes, :active, :boolean
  end
end
