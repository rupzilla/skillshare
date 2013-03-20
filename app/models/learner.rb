class Learner < ActiveRecord::Base
  attr_accessible :first_name, :interests, :last_name, :major, :user_id
  
  # Relationships
  has_one :user
  
  # Other methods
  def proper_name
    "#{first_name} #{last_name}"
  end
  
end
