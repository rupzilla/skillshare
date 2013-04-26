class Upvote < ActiveRecord::Base
  attr_accessible :active, :user_id, :workshop_id
  
  # Relationships
  belongs_to :workshop
  belongs_to :user
  
  validates_presence_of :user
  validates_presence_of :workshop
  validate :no_double_voting
  
  # Scope
  scope :for_workshop, lambda {|workshop_id| where("workshop_id = ?", workshop_id) }
  scope :for_user, lambda {|user_id| where("user_id = ?", user_id) }
    
  # Scope
  # scope :for_workshop, lambda {|workshop_id| where("upvotes.workshop_id = ?", workshop_id) }
  
  
  
end
