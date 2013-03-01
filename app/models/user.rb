class User < ActiveRecord::Base
  attr_accessible :email, :password_digest, :learner_id #added for phase 5
  
  # Relationship
  belongs_to :learner_id
  

  