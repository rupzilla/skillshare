FactoryGirl.define do
  factory :workshop do
    category "Adobe"
	description "Photoshop"
	date 3.days.from_now.to_date
	start_time Time.local(2000,1,1,11,0,0)
	end_time Time.local(2000,1,1,14,0,0)
	size 15
	location "Porter Hall 100"
	association :sharer
	subdescription "Photoshop is the sheeit"
	learner_id 1
    active true
  end
  
  factory :sharer do
	association :user
	credentials "Tech. consulting, chef"
	major "Information Systems"
#    active true
  end
  
  factory :subscription do
    association :workshop
    association :user
    active true
  end
  
  factory :upvote do
    association :workshop
	association :user
	active true
  end
    
  factory :user do
    first_name "Barnik"
	last_name "Saha"
	email "tesla@example.com"
	interests "Magic tricks"
    password_digest "$2a$10$o6xZS3B73OZ8GqRoM6uGPOEzZL0pOh6Yhk3qIMp2Qr2Fap.bshK5S"
	active true
  end
end
