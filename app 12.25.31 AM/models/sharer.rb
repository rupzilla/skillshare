class Sharer < ActiveRecord::Base
  attr_accessible :credentials, :first_name, :last_name, :major, :user_id

  # Relationships
  has_many :workshops
  has_one :user
  has_many :subscriptions, :through => :workshops
  
  # Other methods
  def proper_name
    "#{first_name} #{last_name}"
  end
end
