class Workshop < ActiveRecord::Base
  attr_accessible :active, :category, :date, :description, :end_time, :learner_id, :location, :sharer_id, :size, :start_time, :subdescription
  
#  before_destroy :delete_sub_upv
  
  # Relationships
  has_many :upvotes, :dependent => :destroy
  has_many :subscriptions, :dependent => :destroy
  has_many :users, :through => :subscriptions
  belongs_to :sharer
  
  validates_numericality_of :size, :only_integer => true, :greater_than => 0
  validates_presence_of :sharer
  validates_presence_of :description
  validate :only_one_workshop
#  validates_date :date, :after => lambda{Date.current}#, :unless => :active == false
# validates_uniqueness_of :sharer
  
  # scope :workshop_order,
  #  :select => "workshops.* as count",
  #  :joins => :upvotes,
  # 
  #  :group => "workshop_id",
  #  :order => 'workshop.upvote.count desc'
  
#  scope :alphabetical, order('description')
  scope :for_category, lambda {|category| where("category = ?", "#{category}") }
  scope :for_sharer, lambda {|sharer_id| where("sharer_id = ?", sharer_id) }
  scope :active, where('active LIKE ?', true)
  scope :inactive, where('active LIKE ?', false)
  scope :by_upvotes_size, Workshop.joins("LEFT OUTER JOIN upvotes ON workshop_id = workshops.id").group("workshops.id").order('COUNT(workshop_id) DESC')
  scope :search, lambda { |term| where('description LIKE ?', "#{term}%").order("description") }

  private
	def delete_sub_upv
#		if !self.active
		Subscription.destroy_all "workshop_id = #{self.workshop_id}"
		Upvote.destroy_all "workshop_id = #{self.workshop_id}"
#		end
	end

	def only_one_workshop
		all_ws = Workshop.for_sharer(self.sharer_id).active
		if all_ws.size >= 1 then
			errors.add(:sharer_id, "is already teaching a workshop.")
		end
	end

  #scope :by_upvotes_size, joins(:upvotes).group(:workshop_id).order('COUNT(workshop_id) DESC')
  #default_scope :order => "upvotes_count DESC"

#@posts = Post.joins("LEFT OUTER JOIN users ON users.id = posts.user_id").joins(:blog).select

end