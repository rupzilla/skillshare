require 'test_helper'

class SharerTest < ActiveSupport::TestCase
	should have_many(:workshops)
	should have_one(:user)
	should have_many(:subscriptions).through(:workshops)
	
	should validate_presence_of(:credentials)
	should validate_presence_of(:user)

   # Need to do the rest with a context
   context "Creating three users, three sharers, two workshops, and four upvotes" do
     # create the objects I want with factories
    setup do 
		@rupa = FactoryGirl.create(:user)
		@rupatut = FactoryGirl.create(:sharer, :user => @rupa)
		@ryan = FactoryGirl.create(:user, :first_name => "Ryan", :last_name => "Rowe")
		@ryantut = @rupatut = FactoryGirl.create(:sharer, :user => @ryan)
		@eman = FactoryGirl.create(:user, :first_name => "Emannuel", :last_name => "Ruiz")
		@emantut = FactoryGirl.create(:sharer, :user => @eman)
		@adobps = FactoryGirl.create(:workshop, :sharer => nil, :active => false)
		@adobau = FactoryGirl.create(:workshop, :description => "Audition", :sharer => @rupatut)
		@anima = FactoryGirl.create(:workshop, :category => "Art", :description => "Animation", :sharer => @emantut)
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
		@eman.destroy
		@emantut.destroy
		@adobps.destroy
		#@adobau.destroy
		@anima.destroy
		@upvrups.destroy
		@upvryps.destroy
		@upvemps.destroy
		@upvryan.destroy
    end

	# should "list sharers by number of workshops teaching/taught" do
		# assert_equal ["Rupa", "Emannuel"], Sharer.by_workshops.map{|s| s.first_name}
		# assert_equal [2, 1], Sharer.by_workshops.map{|s| s.workshops.all.size}
	# end

	should "test proper_name function" do
		assert_equal "Emannuel Ruiz", @eman.proper_name
	end
	
	should "correctly identify whether each user has a workshop or not" do
		assert_equal true, @rupatut.has_workshop?
		assert_equal nil, @ryantut.has_workshop?
		assert_equal true, @eman.has_workshop?
	end
	
	should "ensure each workshop has just one active workshop" do
		@biol = FactoryGirl.build(:workshop, :description => "Biology yo", :sharer => @emantut)
		deny @biol.valid?
	end
   end
end
