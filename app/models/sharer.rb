class Sharer < ActiveRecord::Base
#	attr_accessible :credentials, :first_name, :last_name, :major, :user_id
  attr_accessible :credentials, :major, :user_id

  # Relationships
  has_one :workshop
  belongs_to :user
  has_many :subscriptions, :through => :workshop
  
  #validate :only_one_workshop
  validates_presence_of :user
#  validates_uniqueness_of :user
  validates_presence_of :credentials
#  validate :only_one_workshop
  
  #Scopes
  scope :search, lambda { |term| joins(:user).where('first_name LIKE ? OR last_name LIKE ?', "#{term}%", "#{term}%").order("first_name", "last_name")  }

  # Other methods
  def first_name
	User.find(self.user_id).first_name
  end
  
  def last_name
	User.find(self.user_id).last_name
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

	
end
