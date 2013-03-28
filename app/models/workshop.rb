class Workshop < ActiveRecord::Base
  attr_accessible :active, :category, :date, :description, :end_time, :learner_id, :location, :sharer_id, :size, :start_time, :subdescription
 
  # Relationships
  has_many :upvotes
  has_many :subscriptions
  has_many :users, :through => :subscriptions
  belongs_to :sharer
  
  # scope :workshop_order,
  #  :select => "workshops.* as count",
  #  :joins => :upvotes,
  # 
  #  :group => "workshop_id",
  #  :order => 'workshop.upvote.count desc'
  

end