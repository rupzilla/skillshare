class Sharer < ActiveRecord::Base
  attr_accessible :credentials, :first_name, :last_name, :major, :user_id

  # Relationships
  has_one :workshop
  has_one :user
  has_many :subscriptions, :through => :workshops
  
  validate :only_one_workshop
  
  #Scopes
  scope :search, lambda { |term| where('first_name LIKE ?', "#{term}%").order("first_name") }
  
  
  # Other methods
  def first_name
	self.user.first_name
  end
  
  def last_name
	self.user_last_name
  end
  
  def proper_name
	fname = User.find(self.user_id).first_name
	lname = User.find(self.user_id).last_name
	"#{fname} #{lname}"
  end

  def has_workshop?
     has_a_workshop = self.workshop
     
     if has_a_workshop.nil?
        return nil
     else
       return true
      end
       
  end

  private
	def only_one_workshop
		if !self.workshop.nil?
			ws = Workshop.find_by_sharer_id(self.id).active
			unless ws.size <= 1
				error.add_to_base("You cannot teach more than one workshops at a time")
			end
		end
	end
	
end
