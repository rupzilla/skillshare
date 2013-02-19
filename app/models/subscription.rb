class Subscription < ActiveRecord::Base
  attr_accessible :active, :user_id, :workshop_id
end
