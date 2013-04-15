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
  
  scope :by_upvotes_size, Workshop.joins("LEFT OUTER JOIN upvotes ON workshop_id = workshops.id").group("workshops.id").order('COUNT(workshop_id) DESC')
  scope :search, lambda { |term| where('workshops.description LIKE ?', "#{term}%").order("workshop.description") }
  
  #scope :by_upvotes_size, joins(:upvotes).group(:workshop_id).order('COUNT(workshop_id) DESC')
  #default_scope :order => "upvotes_count DESC"

#@posts = Post.joins("LEFT OUTER JOIN users ON users.id = posts.user_id").joins(:blog).select

end