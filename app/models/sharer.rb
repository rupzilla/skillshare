class Sharer < ActiveRecord::Base
  attr_accessible :credentials, :first_name, :last_name, :major, :user_id

  # Relationships
  has_one :workshop
  has_one :user
  has_many :subscriptions, :through => :workshops
  
  #Scopes
  scope :search, lambda { |term| where('first_name LIKE ? OR last_name LIKE ?', "#{term}%", "#{term}%").order("first_name", "last_name")  } 
  # Other methods
  def proper_name
    "#{first_name} #{last_name}"
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
