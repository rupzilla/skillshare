class Upvote < ActiveRecord::Base
  attr_accessible :active, :user_id, :workshop_id
  
  # Relationships
  belongs_to :workshop
  belongs_to :user
  
  # Scope
  # scope :for_workshop, lambda {|workshop_id| where("upvotes.workshop_id = ?", workshop_id) }
 
  
  
end
