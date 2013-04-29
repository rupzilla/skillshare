class AddActiveToUpvotes < ActiveRecord::Migration
  def change
    add_column :upvotes, :active, :boolean, :default => true
  end
end
