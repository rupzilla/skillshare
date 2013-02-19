class Upvote < ActiveRecord::Base
  attr_accessible :active, :user_id, :workshop_id
end
