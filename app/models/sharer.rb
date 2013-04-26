class Sharer < ActiveRecord::Base
  attr_accessible :credentials, :first_name, :last_name, :major, :user_id

  # Relationships
  has_one :workshop
  has_one :user
  has_many :subscriptions, :through => :workshops
  
  #Scopes
  scope :search, lambda { |term| where('first_name LIKE ?', "#{term}%").order("first_name") }
  
  
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

   # def reformat_names
     # ssn = self.ssn.to_s      # change to string in case input as all numbers 
     # ssn.gsub!(/[^0-9]/,"")   # strip all non-digits
     # self.ssn = ssn           # reset self.ssn to new string
   # end
  
end
