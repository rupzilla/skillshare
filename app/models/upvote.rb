class Upvote < ActiveRecord::Base
  attr_accessible :active, :user_id, :workshop_id
  
  # Relationships
  belongs_to :workshop
  belongs_to :user
  
  validates_presence_of :user, :workshop

  validate :no_double_upvoting, :on => :create
  
  # Scope
  scope :for_workshop, lambda {|workshop_id| where("workshop_id = ?", workshop_id) }
  scope :for_user, lambda {|user_id| where("user_id = ?", user_id) }
    
  # Scope
  # scope :for_workshop, lambda {|workshop_id| where("upvotes.workshop_id = ?", workshop_id) }

  private
	  def no_double_upvoting
		all_upvotes = Upvote.for_user(self.user_id).for_workshop(self.workshop_id)
		if all_upvotes.size >= 1 then
			errors.add(:user_id, "has already upvoted this workshop.")
		end
	  end

end
