require 'test_helper'

class UserTest < ActiveSupport::TestCase
	should have_one(:sharer)
	should have_many(:subscriptions)
	should have_many(:workshops).through(:subscriptions)
	should have_many(:upvotes)

  # Validating email...
  should validate_presence_of(:email)
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  
  should allow_value("fred@fred.com").for(:email)
  should allow_value("fred@andrew.cmu.edu").for(:email)
  should allow_value("my_fred@fred.org").for(:email)
  should allow_value("fred123@fred.gov").for(:email)
  should allow_value("my.fred@fred.net").for(:email)
  
  should_not allow_value("fred").for(:email)
  should_not allow_value("fred@fred,com").for(:email)
  should_not allow_value("fred@fred.uk").for(:email)
  should_not allow_value("my fred@fred.com").for(:email)
  should_not allow_value("fred@fred.con").for(:email)
  
   # Need to do the rest with a context
   context "Creating three users, three sharers, three workshops, three subscriptions, and four upvotes" do
     # create the objects I want with factories
    setup do 
		@ryan = FactoryGirl.create(:user, :first_name => "Ryan", :last_name => "Rowe")
		@barn = FactoryGirl.create(:user, :email => "faraday@example.com")
		# @barntut = FactoryGirl.create(:sharer, :user => @barn)
		@eman = FactoryGirl.create(:user, :first_name => "Emannuel", :last_name => "Ruiz", :email => "lavoisier@example.com")
		# @emantut = FactoryGirl.create(:sharer, :user => @eman)
		@adobps = FactoryGirl.create(:workshop, :sharer_id => 1)
		@adobau = FactoryGirl.create(:workshop, :description => "Audition", :sharer_id => 2)
		@anima = FactoryGirl.create(:workshop, :category => "Art", :description => "Animation", :sharer_id => 3)
		@ryansubps = FactoryGirl.create(:subscription, :workshop => @adobps, :user => @ryan)
		@emansubau = FactoryGirl.create(:subscription, :workshop => @adobau, :user => @eman)
		@ryansubau = FactoryGirl.create(:subscription, :workshop => @adobau, :user => @ryan)
		@upvbaps = FactoryGirl.create(:upvote, :user => @barn, :workshop => @adobps)
		@upvryps = FactoryGirl.create(:upvote, :user => @ryan, :workshop => @adobps)
		@upvemps = FactoryGirl.create(:upvote, :user => @eman, :workshop => @adobps)
		@upvryan = FactoryGirl.create(:upvote, :user => @ryan, :workshop => @anima)
    end

     # and provide a teardown method as well
    teardown do
		@ryan.destroy
		@barn.destroy
		# @barntut.destroy
		@eman.destroy
		# @emantut.destroy
		@adobps.destroy
		@adobau.destroy
		@anima.destroy
		@ryansubps.destroy
		@emansubau.destroy
		@ryansubau.destroy
		@upvbaps.destroy
		@upvryps.destroy
		@upvemps.destroy
		@upvryan.destroy
    end
	
    should "force users to have unique emails" do
		@repeat_email = FactoryGirl.build(:user, :first_name => "Steve", :last_name => "Crawford", :email => "tesla@example.com")
		deny @repeat_email.valid?
    end
	
	# should "correctly identify whether each user is a sharer or not" do
		# assert_equal true, @barn.is_sharer?
		# assert_equal false, @ryan.is_sharer?
		# assert_equal true, @eman.is_sharer?
	# end
	
	# # should "test alphabetical scope" do
		# # assert_equal [@barn.id, @ryan.id, @eman.id], User.alphabetical.map{|u| u.id}
	# # end
	
	should "test proper_name function" do
		assert_equal "Barnik Saha", @barn.proper_name
		assert_equal "Ryan Rowe", @ryan.proper_name
		assert_equal "Emannuel Ruiz", @eman.proper_name
	end
	
	should "test workshop_upvotes function" do
		assert @ryan.workshop_upvotes.include?(@adobps.id)
		assert @ryan.workshop_upvotes.include?(@anima.id)
		assert_equal 2, @ryan.workshop_upvotes.size
		assert_equal [@adobps.id], @barn.workshop_upvotes
		assert_equal [@adobps.id], @eman.workshop_upvotes
	end

	should "test workshop_subscriptions function" do
		assert @ryan.workshop_subscriptions.include?(@adobps.id)
		assert @ryan.workshop_subscriptions.include?(@adobau.id)
		assert_equal 2, @ryan.workshop_subscriptions.size
		assert_equal [], @barn.workshop_subscriptions
		assert_equal [@adobau.id], @eman.workshop_subscriptions
	end

	should "test get_workshop_subscription function" do
		assert_equal @ryansubps, @ryan.get_workshop_subscription(@adobps.id)
		assert_equal @ryansubau, @ryan.get_workshop_subscription(@adobau.id)
		assert_equal @emansubau, @eman.get_workshop_subscription(@adobau.id)
	end

	should "test get_workshop_upvote function" do
		assert_equal @upvbaps, @barn.get_workshop_upvote(@adobps.id)
		assert_equal @upvemps, @eman.get_workshop_upvote(@adobps.id)
		assert_equal @upvryps, @ryan.get_workshop_upvote(@adobps.id)
		assert_equal @upvryan, @ryan.get_workshop_upvote(@anima.id)
	end

   end
end
