class AddActiveToWorkshop < ActiveRecord::Migration
  def change
    add_column :workshops, :active, :boolean, :default => true
  end
end
