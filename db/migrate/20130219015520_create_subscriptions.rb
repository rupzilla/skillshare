class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :workshop_id
      t.integer :user_id
      t.boolean :active, :default => true

      t.timestamps
    end
  end
end
