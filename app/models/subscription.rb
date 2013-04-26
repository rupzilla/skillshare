class Subscription < ActiveRecord::Base
  attr_accessible :active, :user_id, :workshop_id
  
  # Relationships
  belongs_to :workshop
  belongs_to :user

  validates_presence_of :user
  validates_presence_of :workshop
  
  # Scope
  scope :for_workshop, lambda {|workshop_id| where("workshop_id = ?", workshop_id) }
  scope :for_user, lambda {|user_id| where("user_id = ?", user_id) }
  
end
