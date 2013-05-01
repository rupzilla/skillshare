require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
	should belong_to(:workshop)
	should belong_to(:user)
	
	# should validate_presence_of(:workshop)
	# should validate_presence_of(:user)

   # Need to do the rest with a context
   context "Creating three users, three sharers, three workshops, and three subscriptions" do
     # create the objects I want with factories
    setup do 
		@ryan = FactoryGirl.create(:user, :first_name => "Ryan", :last_name => "Rowe")
		@ryantut = FactoryGirl.create(:sharer, :user => @ryan)
		@barn = FactoryGirl.create(:user, :email => "faraday@example.com")
		@barntut = FactoryGirl.create(:sharer, :user => @barn)
		@rupa = FactoryGirl.create(:user, :first_name => "Rupa", :last_name => "Patel", :email => "lavoisier@example.com")
		@rupatut = FactoryGirl.create(:sharer, :user => @rupa)
		@adobps = FactoryGirl.create(:workshop, :sharer => @rupatut)
		@adobau = FactoryGirl.create(:workshop, :description => "Audition", :sharer => @barntut)
		@anima = FactoryGirl.create(:workshop, :category => "Art", :description => "Animation", :sharer => @ryantut)
		@ryansubps = FactoryGirl.create(:subscription, :workshop => @adobps, :user => @ryan)
		@rupasubau = FactoryGirl.create(:subscription, :workshop => @adobau, :user => @rupa)
		@ryansubau = FactoryGirl.create(:subscription, :workshop => @adobau, :user => @ryan)
    end

     # and provide a teardown method as well
    teardown do
		@ryan.destroy
		@ryantut.destroy
		@barn.destroy
		@barntut.destroy
		@rupa.destroy
		@rupatut.destroy
		@adobps.destroy
		@adobau.destroy
		@anima.destroy
		@ryansubps.destroy
		@rupasubau.destroy
		@ryansubau.destroy
    end

	should "show the correct number of subscriptions for each workshop" do
		assert_equal [@ryansubps.id], Subscription.for_workshop(@adobps.id).map{|s| s.id}
		assert_equal 0, Subscription.for_workshop(@anima.id).size
		assert_equal 2, Subscription.for_workshop(@adobau.id).size
	end

	should "show the correct number of subscriptions for each user" do
		assert_equal 2, Subscription.for_user(@ryan.id).size
		assert_equal [@rupasubau.id], Subscription.for_user(@rupa.id).map{|s| s.id}
		assert_equal 0, Subscription.for_user(@barn.id).size
	end
	
	should "not have a user subscribed twice for a single workshop" do
		rupasuban = Factory.build(:subscription, :workshop => @anima, :user => @rupa)
		assert rupasuban.valid?
		ryansubps2 = Factory.build(:subscription, :workshop => @adobps, :user => @ryan)
		deny ryansubps2.valid?
	end
	
	should "not let a sharer subscribe to his own workshop" do
		barnsubau = Factory.build(:subscription, :workshop => @adobau, :user => @barn)
		deny barnsubau.valid?
	end
	
	should "not allow a subscription to have no workshop" do
		no_ws = Factory.build(:subscription, :workshop => nil, :user => @barn)
		deny no_ws.valid?
	end

	should "not allow a subscription to have no user" do
		no_us = Factory.build(:subscription, :workshop => @anima, :user => nil)
		deny no_us.valid?
	end
	
   end
end
