require 'test_helper'

class UpvoteTest < ActiveSupport::TestCase
	should belong_to(:workshop)
	should belong_to(:user)
	
	should validate_presence_of(:user)
	should validate_presence_of(:workshop)

   # Need to do the rest with a context
   context "Creating a user, a sharer, a workshop, and four upvotes" do
     # create the objects I want with factories
    setup do 
		@ryan = FactoryGirl.create(:user, :first_name => "Ryan", :last_name => "Rowe")
		@ryantut = FactoryGirl.create(:sharer, :user => @ryan)
		@eman = FactoryGirl.create(:user, :first_name => "Emannuel", :last_name => "Ruiz", :email => "faraday@example.com")
		@emantut = FactoryGirl.create(:sharer, :user => @eman)
		@rupa = FactoryGirl.create(:user, :first_name => "Rupa", :last_name => "Patel", :email => "lavoisier@example.com")
		@rupatut = FactoryGirl.create(:sharer, :user => @rupa)
		@adobps = FactoryGirl.create(:workshop, :sharer => @ryantut)
		@adobau = FactoryGirl.create(:workshop, :description => "Audition", :sharer => @rupatut)
		@anima = FactoryGirl.create(:workshop, :category => "Art", :description => "Animation", :sharer => @emantut)
		@upvryps = FactoryGirl.create(:upvote, :user => @ryan, :workshop => @adobps)
		@upvrups = FactoryGirl.create(:upvote, :user => @rupa, :workshop => @adobps)
		@upvryan = FactoryGirl.create(:upvote, :user => @ryan, :workshop => @anima)
		@upvemps = FactoryGirl.create(:upvote, :user => @eman, :workshop => @adobps)
    end

     # and provide a teardown method as well
    teardown do
		@ryan.destroy
		@ryantut.destroy
		@eman.destroy
		@emantut.destroy
		@rupa.destroy
		@rupatut.destroy
		@adobps.destroy
		@adobau.destroy
		@anima.destroy
		@upvryps.destroy
		@upvrups.destroy
		@upvryan.destroy
		@upvemps.destroy
    end

	should "show the correct number of upvotes for each workshop" do
		assert_equal [@upvryan.id], Upvote.for_workshop(@anima.id).map{|s| s.id}
		assert_equal 3, Upvote.for_workshop(@adobps.id).size
		assert_equal 0, Upvote.for_workshop(@adobau.id).size
	end

	should "show the correct number of upvotes for each user" do
		assert_equal 2, Upvote.for_user(@ryan.id).size
		assert_equal [@upvrups.id], Upvote.for_user(@rupa.id).map{|s| s.id}
		assert_equal 1, Upvote.for_user(@eman.id).size
	end
	
	should "not have a user upvoting twice for a single workshop" do
		upvruan = Factory.build(:upvote, :workshop => @anima, :user => @rupa)
		assert upvruan.valid?
		upvrups2 = Factory.build(:upvote, :workshop => @adobps, :user => @rupa)
		deny upvrups2.valid?
	end
   end
end
