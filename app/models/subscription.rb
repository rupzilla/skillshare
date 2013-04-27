class Subscription < ActiveRecord::Base
  attr_accessible :active, :user_id, :workshop_id
  
  # Relationships
  belongs_to :workshop
  belongs_to :user

  validates_presence_of :user
  validates_presence_of :workshop
  
  validate :no_double_subbing
  
  # Scope
  scope :for_workshop, lambda {|workshop_id| where("workshop_id = ?", workshop_id) }
  scope :for_user, lambda {|user_id| where("user_id = ?", user_id) }

  private
	  def no_double_subbing
		all_subbies = Subscription.for_user(self.user_id).for_workshop(self.workshop_id)
		if all_subbies.size >= 1 then
			errors.add(:user_id, "has already subscribed to this workshop.")
		end
	  end

end
