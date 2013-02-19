class CreateLearners < ActiveRecord::Migration
  def change
    create_table :learners do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :interests
      t.string :major

      t.timestamps
    end
  end
end
