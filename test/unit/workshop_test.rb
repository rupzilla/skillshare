require 'test_helper'

class WorkshopTest < ActiveSupport::TestCase
	should have_many(:upvotes)
	should have_many(:subscriptions)
	should have_many(:users).through(:subscriptions)
	should belong_to(:sharer)
		
	should allow_value(2.weeks.from_now.to_date).for(:date)
	should allow_value(1.week.ago.to_date).for(:date)
	should allow_value(Date.current).for(:date)
	
	should_not allow_value(nil).for(:date)
	should_not allow_value("bad").for(:date)
	should_not allow_value(78).for(:date)
		
   # Need to do the rest with a context
   context "Creating six employees and three stores with five assignments" do
     # create the objects I want with factories
    setup do 
		@rupa = FactoryGirl.create(:user)
		@rupatut = FactoryGirl.create(:sharer, :user => @rupa)
		@ryan = FactoryGirl.create(:user, :first_name => "Ryan", last_name => "Rowe")
		@ryantut = FactoryGirl.create(:sharer, :user => @ryan)
		@eman = FactoryGirl.create(:user, :first_name => "Emannuel", :last_name => "Ruiz")
		@emantut = FactoryGirl.create(:sharer, :user => @eman)
		@adobps = FactoryGirl.create(:workshop, :sharer => @rupatut)
		@adobau = FactoryGirl.create(:workshop, :description => "Audition", :sharer => @ryantut, :subdescription => "Audition is da sheeit", :active => false)
		@anima = FactoryGirl.create(:workshop, :category => "Art", :description => "Animation", :sharer => @emantut, :subdescription => "Animation rules over everything and you know it")
		@upvrups = FactoryGirl.create(:upvote, :user => @rupa, :workshop => @adobps)
		@upvryps = FactoryGirl.create(:upvote, :user => @ryan, :workshop => @adobps)
		@upvemps = FactoryGirl.create(:upvote, :user => @eman, :workshop => @adobps)
		@upvryan = FactoryGirl.create(:upvote, :user => @ryan, :workshop => @anima)
    end

     # and provide a teardown method as well
    teardown do
		@rupa.destroy
		@rupatut.destroy
		@ryan.destroy
		@ryantut.destroy
		@eman.destroy
		@emantut.destroy
		@adobps.destroy
		@adobau.destroy
		@anima.destroy
		@upvrups.destroy
		@upvryps.destroy
		@upvemps.destroy
		@upvryan.destroy
    end
	
	should "list all workshops in the order of how many upvotes they have" do
		assert_equal ["Photoshop", "Animation", "Audition"], Workshop.by_upvotes.map{|w| w.description}
		assert_equal [3, 1, 0], Workshop.by_upvotes.map{|w| w.upvotes.size}
    end
	
	should "test :alphabetical scope" do
		assert_equal [@anima.id, @adobau.id, @adobps.id], Workshop.alphabetical{|w| w.id}
	end
	
	should "distinguish workshops by activeness; can mess up if alphabetical scope doesn't work" do
		assert_equal [@anima.id, @adobau.id], Workshop.active.alphabetical{|w| w.id}
		assert_equal [@adobps], Workshop.inactive.alphabetical{|w| w.id}
	end
	
	should "not have an active workshop with a past date" do
		@past_workshop = FactoryGirl.build(:workshop, :description => "Flash Professional", :sharer => @ryantut, :date => 3.days.ago.to_date, :active => true)
		deny @past_workshop.valid?
	end
	
	should "not have two active workshops with the same sharer" do
		@buddhism = FactoryGirl.build(:workshop, :description => "How to Reach Nirvana", :sharer => @emantut, :active => true)
		deny @buddhism.valid?
	end
   end
end
