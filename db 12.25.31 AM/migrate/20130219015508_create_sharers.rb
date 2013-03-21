class CreateSharers < ActiveRecord::Migration
  def change
    create_table :sharers do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :credentials
      t.string :major

      t.timestamps
    end
  end
end
