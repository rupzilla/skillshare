class Upvote < ActiveRecord::Base
  attr_accessible :active, :user_id, :workshop_id, :my_vote
  
  # Relationships
  belongs_to :workshop
  belongs_to :user
  
  # validates_uniqueness_of :user_id
  # Scope
  scope :for_workshop, lambda {|workshop_id| where("upvotes.workshop_id = ?", workshop_id) }
  scope :active, where('active = ?', true)
  
  
end
