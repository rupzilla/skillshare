class Learner < ActiveRecord::Base
  attr_accessible :first_name, :interests, :last_name, :major, :user_id
end
