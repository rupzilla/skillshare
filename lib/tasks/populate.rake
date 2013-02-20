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

    # Step 1a: Add Emmanuel as learner
    el = Learner.new
    el.first_name = "Emmanuel"
    el.last_name = "Ruiz"
    el.interests = "Adobe After Effects, Adobe Photoshop"
    el.major = "Information Systems"
    el.save!
    # au = User.new
    # au.email = "alex@example.com"
    # au.password = "creamery"
    # au.password_confirmation = "creamery"
    # au.employee_id = ae.id
    # au.save!

    # Step 1b: Add Mark as employee and user
     # Step 1a: Add Barnik as learner
    bl = Learner.new
    bl.first_name = "Barnik"
    bl.last_name = "Saha"
    bl.interests = "Adobe Photoshop, Adobe Illustrator"
    bl.major = "Information Systems"
    bl.save!
    # au = User.new
    # au.email = "alex@example.com"
    # au.password = "creamery"
    # au.password_confirmation = "creamery"
    # au.employee_id = ae.id
    # au.save!

    # Step 1c: Add Rupa as sharer
    rs = Sharer.new
    rs.first_name = "Rupa"
    rs.last_name = "Patel"
    rs.credentials = "013125299"
    rs.major = "1993-01-25"
    rs.save!
    # ru = User.new
    # ru.email = "rachel@example.com"
    # ru.password = "creamery"
    # ru.password_confirmation = "creamery"
    # ru.employee_id = re.id
    # ru.save!

    # Step 2: Add some workshops
	ws1 = Workshop.new
	ws1.active = true
	ws1.start_time = "21:30:00"
	ws1.end_time = "22:30:00"
	ws1.date = "1993-01-25"
	ws1.size = "15"
	ws1.category = "Science"
	ws1.location = "Baker Hall"
	ws1.subdescription = "We work hard play hard"
	ws1.description = "Best Workshop NA"
	ws1.save!

	# Step 2a: Add new Upvote
    uv = Upvote.new
	uv.active = true
    uv.save!


	# Step 2a: Add new Subscription
    ss = Subscription.new
	ss.active = true
	ss.workshop_id = ss.id
    ss.save!



    # # Step 3a: Add two managers for each store
    # active_stores = Store.active.each do |store|
      # # Add manager
      # 2.times do |i|
        # mgr = Employee.new
        # mgr.first_name = Faker::Name.first_name
        # mgr.last_name = Faker::Name.last_name
        # mgr.ssn = rand(9 ** 9).to_s.rjust(9,'0')
        # mgr.date_of_birth = (rand(9)+20).years.ago.to_date
        # mgr.phone = rand(10 ** 10).to_s.rjust(10,'0')
        # mgr.active = true
        # mgr.role = "manager"
        # mgr.save!
        # # Assign to store
        # assign_mgr = Assignment.new
        # assign_mgr.store_id = store.id
        # assign_mgr.employee_id = mgr.id
        # assign_mgr.start_date = (rand(14)+2).months.ago.to_date
        # assign_mgr.end_date = nil
        # assign_mgr.pay_level = [4,5].sample
        # assign_mgr.save!
      # end
    # end

    # # Step 3b: Assign Rachel as a manager to the first store
    # first_store = Store.active.first
    # assign_rachel = Assignment.new
    # assign_rachel.store_id = first_store.id
    # assign_rachel.employee_id = re.id
    # assign_rachel.start_date = (rand(14)+2).months.ago.to_date
    # assign_rachel.end_date = nil
    # assign_rachel.pay_level = 5
    # assign_rachel.save!

    # # Step 3c: Assign Dusty as an employee to the first store
    # assign_dusty = Assignment.new
    # assign_dusty.store_id = first_store.id
    # assign_dusty.employee_id = de.id
    # assign_dusty.start_date = (rand(6)+1).months.ago.to_date
    # assign_dusty.end_date = nil
    # assign_dusty.pay_level = 2
    # assign_dusty.save!

    # # Step 4: Add some other employees to the system
    # store_ids = Store.all.map(&:id)
    # Employee.populate 100 do |employee|
      # # get some fake data using the Faker gem
      # employee.first_name = Faker::Name.first_name
      # employee.last_name = Faker::Name.last_name
      # employee.role = "employee"
      # employee.ssn = rand(9 ** 9).to_s.rjust(9,'0')
      # employee.phone = rand(10 ** 10).to_s.rjust(10,'0')
      # employee.date_of_birth = 22.years.ago..15.years.ago
      # not_active = rand(5)
      # if not_active.zero?
        # employee.active = false
      # else
        # employee.active = true
      # end
      # employee.created_at = Time.now
      # employee.updated_at = Time.now

      # # Step 5: Add an assignment for each employee
      # pay_levels = [1,2,3]
      # Assignment.populate 1 do |asn1|
        # asn1.employee_id = employee.id
        # asn1.store_id = store_ids.sample
        # asn1.pay_level = pay_levels.sample
        # asn1.start_date = 2.years.ago..3.months.ago
        # if employee.active
          # asn1.end_date = nil
        # else
          # asn1.end_date = 2.months.ago..2.days.ago
        # end
      # end
    # end

    # # Step 6: Add another assignment for some employees
    # current_assignments = Assignment.current.for_role("employee").all
    # current_assignments.each do |first_assignment|
      # additional_assignments = rand(4)
      # unless additional_assignments.zero?
        # number_of = (2..49).to_a.sample
        # asn2 = Assignment.new
          # asn2.employee_id = first_assignment.employee_id
          # asn2.store_id = store_ids.sample
          # asn2.pay_level = first_assignment.pay_level + 1
          # asn2.start_date = number_of.days.ago
          # asn2.end_date = nil
        # asn2.save!
      # end
    # end

    # # Step 7: Add some jobs
    # jobs = %w[Cashier Mopping Make\ ice\ cream ]
    # jobs.each do |j|
      # job = Job.new
      # job.name = j
      # job.description = "Best job ever"
      # job.active = true
      # job.save!
    # end

    # # Step 8: Add some shifts to current assignments
    # current_assignments = Assignment.current.for_role("employee").all
    # current_assignments.each do |assignment|
      # shift1 = Shift.new
      # shift1.assignment_id = assignment.id
      # # number_of = (6..12).to_a.sample
      # shift1.date = assignment.start_date + 1
      # start_hour = (11..18).to_a.sample
      # shift1.start_time = Time.local(2000,1,1,start_hour,0,0)
      # shift1.save!

      # additional_shifts = rand(4)
      # unless additional_shifts.zero?
        # shift2 = Shift.new
        # shift2.assignment_id = assignment.id
        # # number_of = (2..5).to_a.sample
        # shift2.date = assignment.start_date + 2
        # start_hour = (11..18).to_a.sample
        # shift2.start_time = Time.local(2000,1,1,start_hour,0,0)
        # shift2.save!
      # end
    # end
   end
end