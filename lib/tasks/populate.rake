namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    # Invoke rake db:migrate just in case...
    Rake::Task['db:migrate'].invoke

    # Need two gems to make this work: faker & populator
    # Docs at: http://populator.rubyforge.org/
    require 'populator'
    # Docs at: http://faker.rubyforge.org/rdoc/
    require 'faker'

    # Step 0: clear any old data in the db
    [Learner, Sharer, Upvote, Subscription, Workshop].each(&:delete_all)

    # Step 1: Add some Learners
    el = Learner.new
    el.first_name = "Emmanuel"
    el.last_name = "Ruiz"
    el.interests = "Adobe After Effects, Maya 3d Applications"
    el.major = "Information Systems"



    bl = Learner.new
    bl.first_name = "Barnik"
    bl.last_name = "Saha"
    bl.interests = "Adobe Photoshop, Adobe Illustrator"
    bl.major = "Information Systems"
    bl.save!


    jl = Learner.new
    jl.first_name = "Juhee"
    jl.last_name = "Song"
    jl.interests = "Adobe After Effects, Microsoft Office Suite"
    jl.major = "Information Systems"



    rl = Learner.new
    rl.first_name = "Ryan"
    rl.last_name = "Rowe"
    rl.interests = "iPhone Development, Chemical extraction"
    rl.major = "Information Systems"
    rl.save!

    #Step 2: Make some Sharers

    js = Sharer.new
    js.first_name = "Jimmy"
    js.last_name = "Carter"
    js.credentials = "Policy club, Sports referee "
    js.major = "Internation Relations"
    js.save!


    rs = Sharer.new
    rs.first_name = "Rupa"
    rs.last_name = "Patel"
    rs.credentials = "Cluster Consultant, Chef "
    rs.major = "Information Systems"
    rs.save!

    ds = Sharer.new
    ds.first_name = "Drew"
    ds.last_name = "James"
    ds.credentials = "HTML5 Web Developer, e-Commerce & Online Business "
    ds.major = "Computer Science"
    ds.save!

    ms = Sharer.new
    ms.first_name = "Michael"
    ms.last_name = "Snipes"
    ms.credentials = "Free Style Painting, Music Engineering, Professional Writing for Dr. Suess "
    ms.major = "CFA"
    ms.save!

	#Step 3: Make some Workshops

	ws1 = Workshop.new
	ws1.sharer_id = js.id
	ws1.active = true
	ws1.start_time = "21:30:00"
	ws1.end_time = "22:30:00"
	ws1.date = "1993-01-25"
	ws1.size = "15"
	ws1.category = "Science"
	ws1.location = "Baker Hall"
	ws1.subdescription = "We work hard play hard with chemistry. Learn everything you
	want with chemistry"
	ws1.description = "Chemistry Lab 1"
	ws1.save!


	ws2 = Workshop.new
	ws2.sharer_id = rs.id
	ws2.active = true
	ws2.start_time = "11:30:00"
	ws2.end_time = "12:30:00"
	ws2.date = "1993-01-29"
	ws2.size = "15"
	ws2.category = "Adobe"
	ws2.location = "Tepper Building"
	ws2.subdescription = "This is an introductory course to Photoshop. We definitely
	welcome beginners. We will help you learn all sorts of rules with the tools."
	ws2.description = "Photoshop"
	ws2.save!

	ws3 = Workshop.new
	ws3.sharer_id = ds.id
	ws3.active = true
	ws3.start_time = "13:30:00"
	ws3.end_time = "14:30:00"
	ws3.date = "1995-01-25"
	ws3.size = "15"
	ws3.category = "Information Systems"
	ws3.location = "IS Wing Conference Room"
	ws3.subdescription = "This workshop helps figure out how to hook up a working
	application with a working databse. Learn SQL queries. We will work with
	phpMyAdmin."
	ws3.description = "Database Design"
	ws3.save!


	ws4 = Workshop.new
	ws4.sharer_id = ds.id
	ws4.active = true
	ws4.start_time = "14:30:00"
	ws4.end_time = "15:30:00"
	ws4.date = "2000-02-27"
	ws4.size = "15"
	ws4.category = "Art"
	ws4.location = "CFA Building"
	ws4.subdescription = "This workshop will be an introductory course to black and
	white photography. You will find out how to develop film in the darkroom."
	ws4.description = "Photography"
	ws4.save!

	ws5 = Workshop.new
	ws5.sharer_id = ms.id
	ws5.active = true
	ws5.start_time = "13:30:00"
	ws5.end_time = "14:30:00"
	ws5.date = "2002-02-14"
	ws5.size = "15"
	ws5.category = "Psychology"
	ws5.location = "Porter Hall Basement"
	ws5.subdescription = "This workshop will introduce students to psychology on an
	introductory level. Learn everything you need to know to assess people and read
	them. You can learn to manipulate them and use them to your advantage."
	ws5.description = "Intro to Psychology"
	ws5.save!



	ws6 = Workshop.new
	ws6.sharer_id = ms.id
	ws6.active = true
	ws6.start_time = "15:00:00"
	ws6.end_time = "16:00:00"
	ws6.date = "2013-02-19"
	ws6.size = "5"
	ws6.category = "Art"
	ws6.location = "CFA Building"
	ws6.subdescription = "Looking for a place to learn how make some of the best art you've ever seen.  Come to CFA to learn how to finger paint with the latest styles in the art community.  We will have painting professionals to assist in this workshop.  Hope to see you all there!"
	ws6.description = "Finger Painting"
	ws6.save!

	 # Step 2a: Add new Upvote
	uv = Upvote.new
	uv.active = true
	uv.save!


		# Step 2a: Add new Subscription
	ss = Subscription.new
	ss.active = true
	ss.workshop_id = ss.id
	ss.save!

   end
end