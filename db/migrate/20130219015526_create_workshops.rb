class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.integer :sharer_id
      t.integer :learner_id
      t.boolean :active, :default => true
      t.datetime :start_time
      t.datetime :end_time
      t.date :date
      t.integer :size
      t.string :category
      t.string :location
      t.string :subdescription
      t.string :description

      t.timestamps
    end
  end
end
