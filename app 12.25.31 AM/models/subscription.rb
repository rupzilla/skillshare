class Subscription < ActiveRecord::Base
  attr_accessible :active, :user_id, :workshop_id
  
  # Relationships
  belongs_to :workshop
  belongs_to :user
  
end
