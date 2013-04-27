require 'test_helper'

class UpvoteTest < ActiveSupport::TestCase
	should belong_to(:workshop)
	should belong_to(:user)
	
	should validate_presence_of(:user)

   # Need to do the rest with a context
   context "Creating six employees and three stores with five assignments" do
     # create the objects I want with factories
    setup do 
		@rupa = FactoryGirl.create(:user)
		@rupatut = FactoryGirl.create(:sharer, :user => @rupa)
		@ryan = FactoryGirl.create(:user, :first_name => "Ryan", :last_name => "Rowe")
		@ryantut = FactoryGirl.create(:sharer, :user => @ryan)
		@eman = FactoryGirl.create(:user, :first_name => "Emannuel", :last_name => "Ruiz")
		@emantut = FactoryGirl.create(:sharer, :user => @eman)
		@adobps = FactoryGirl.create(:workshop, :sharer => @rupatut)
		@adobau = FactoryGirl.create(:workshop, :sharer => @emantut)
		@anima = FactoryGirl.create(:workshop, :category => "Art", :description => "Animation", :sharer => @ryantut)
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
	
	should "show the correct number of upvotes for each workshop" do
		assert_equal 3, Upvote.for_workshop(@adobps.id).size
		assert_equal 1, Upvote.for_workshop(@anima.id).size
		assert_equal 0, Upvote.for_workshop(@adobau.id).size
	end

	should "show the correct number of upvotes for each user" do
		assert_equal 2, Upvote.for_user(@ryan.id).size
		assert_equal 1, Upvote.for_user(@eman.id).size
		assert_equal 1, Upvote.for_user(@rupa.id).size
	end
	
	should "not allow two upvotes to have both the same user and the same workshop" do
		upvrups2 = FactoryGirl.build(:upvote, :user => @ryan, :workshop => @anima)
		deny upvrups2.valid?
    end
   end
end
