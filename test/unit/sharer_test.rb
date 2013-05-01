require 'test_helper'

class SharerTest < ActiveSupport::TestCase
	should have_one(:workshop)
	should belong_to(:user)
	should have_many(:subscriptions).through(:workshop)
	
	should validate_presence_of(:credentials)
	should validate_presence_of(:user)

   # Need to do the rest with a context
   context "Creating three users, three sharers, three workshops, three subscriptions, and four upvotes" do
     # create the objects I want with factories
    setup do 
		@ryan = FactoryGirl.create(:user, :first_name => "Ryan", :last_name => "Rowe")
		@ryantut = FactoryGirl.create(:sharer, :user => @ryan)
		@eman = FactoryGirl.create(:user, :first_name => "Emannuel", :last_name => "Ruiz", :email => "lavoisier@example.com")
		@emantut = FactoryGirl.create(:sharer, :user => @eman)
		@rupa = FactoryGirl.create(:user, :first_name => "Rupa", :last_name => "Patel", :email => "marat@example.com")
		@rupatut = FactoryGirl.create(:sharer, :user => @rupa)
		@adobps = FactoryGirl.create(:workshop, :sharer => @ryantut)
		@adobau = FactoryGirl.create(:workshop, :description => "Audition", :sharer => @rupatut)
		# @ryansubps = FactoryGirl.create(:subscription, :workshop => @adobps, :user => @ryan)
		# @emansubau = FactoryGirl.create(:subscription, :workshop => @adobau, :user => @eman)
		# @ryansubau = FactoryGirl.create(:subscription, :workshop => @adobau, :user => @ryan)
		# @upvbaps = FactoryGirl.create(:upvote, :user => @barn, :workshop => @adobps)
		# @upvryps = FactoryGirl.create(:upvote, :user => @ryan, :workshop => @adobps)
		# @upvemps = FactoryGirl.create(:upvote, :user => @eman, :workshop => @adobps)
		# @upvryan = FactoryGirl.create(:upvote, :user => @ryan, :workshop => @anima)
    end

     # and provide a teardown method as well
    teardown do
		@ryan.destroy
		@eman.destroy
		@rupa.destroy
		@emantut.destroy
		@ryantut.destroy
		@rupatut.destroy
		@adobps.destroy
		@adobau.destroy
		# @ryansubps.destroy
		# @emansubau.destroy
		# @ryansubau.destroy
		# @upvbaps.destroy
		# @upvryps.destroy
		# @upvemps.destroy
		# @upvryan.destroy
    end

	# should "list sharers by number of workshops teaching/taught" do
		# assert_equal ["Rupa", "Emannuel"], Sharer.by_workshops.map{|s| s.first_name}
		# assert_equal [2, 1], Sharer.by_workshops.map{|s| s.workshops.all.size}
	# end

	should "test :alphabetical scope" do
		assert_equal [@rupatut.id, @ryantut.id, @emantut.id], Sharer.alphabetical.map{|s| s.id}
	end
	
	should "test proper_name function (and other name functions, briefly)" do
		assert_equal "Emannuel Ruiz", @emantut.proper_name
		assert_equal "Rupa", @rupatut.first_name
		assert_equal "Rowe", @ryantut.last_name
	end
	
	should "correctly identify whether each user has a workshop or not" do
		assert_equal true, @rupatut.has_workshop?
		assert_equal nil, @emantut.has_workshop?
		assert_equal true, @ryantut.has_workshop?
	end
	
   end
end
