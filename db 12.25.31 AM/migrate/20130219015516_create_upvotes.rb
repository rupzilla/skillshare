class CreateUpvotes < ActiveRecord::Migration
  def change
    create_table :upvotes do |t|
      t.integer :workshop_id
      t.integer :user_id
      t.boolean :active

      t.timestamps
    end
  end
end
