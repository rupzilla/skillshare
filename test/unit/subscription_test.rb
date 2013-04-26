require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
	should belong_to(:workshop)
	should belong_to(:user)

   # Need to do the rest with a context
   context "Creating six employees and three stores with five assignments" do
     # create the objects I want with factories
    setup do 
		@barn = FactoryGirl.create(:user)
		@barntut = FactoryGirl.create(:sharer, :user => @barn)
		@adobps = FactoryGirl.create(:workshop, :sharer => @barntut)
		@barnsubps = FactoryGirl.create(:subscription, :workshop => @adobps, :user => @barn)
    end

     # and provide a teardown method as well
    teardown do
		@barn.destroy
		@barntut.destroy
		@adobps.destroy
		@rupasubps.destroy
    end

	should "not have a user subscribed twice for a single workshop" do
		@rupsubps2 = FactoryGirl.build(:subscription, :workshop => @adobps, :user => @rupa)
		deny @rupsubps2.valid?
	end
   end
end
