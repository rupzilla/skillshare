class Workshop < ActiveRecord::Base
  attr_accessible :active, :category, :date, :description, :end_time, :learner_id, :location, :sharer_id, :size, :start_time, :subdescription
 
  # Relationships
  has_many :upvotes
  has_many :subscriptions
  belongs_to :sharer
  
  # Scopes
  
    
  # SELECT COUNT(*) AS "COUNT" FROM WORKSHOPS W LEFT JOIN UPVOTES U WHERE w.id= u.workshop_id GROUP BY (workshop_id) HAVING (COUNT(*)>=0) ORDER BY "COUNT" DESC;
  
  # SELECT COUNT(*) AS "COUNT" FROM UPVOTES U LEFT JOIN WORKSHOPS W ON w.id= u.workshop_id GROUP BY (w.id) ORDER BY "COUNT" DESC;
  
  
  # scope :by_upvotes, joins(:upvote).where("workshop.id = upvote.workshop_id").having("count(*) >= 0").group("workshop_id").select("count.*")  

end
