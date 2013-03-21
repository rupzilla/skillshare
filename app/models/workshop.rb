class Workshop < ActiveRecord::Base
  attr_accessible :active, :category, :date, :description, :end_time, :learner_id, :location, :sharer_id, :size, :start_time, :subdescription
 
  # Relationships
  has_many :upvotes
  has_many :subscriptions
  belongs_to :sharer
  

  # Scope
 # scope :upvotes_decreasing,
  #  select(upvotes.id, count())
  # scope :by_upvotes, select("count(workshop_id) AS upvotes_count").joins(:upvotes).group(:workshop_id).order("upvotes_count DESC")
  
  

  

end
