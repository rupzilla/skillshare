require 'test_helper'

class WorkshopTest < ActiveSupport::TestCase
	should have_many(:upvotes).dependent(:destroy)
	should have_many(:subscriptions).dependent(:destroy)
	should have_many(:users).through(:subscriptions)
	should belong_to(:sharer)
	
	should validate_presence_of(:sharer)
	should validate_presence_of(:description)
	
	should allow_value(2.weeks.from_now.to_date).for(:date)
	should allow_value(1.week.ago.to_date).for(:date)
	should allow_value(Date.current).for(:date)
	
	# should_not allow_value("bad").for(:date)
	# should_not allow_value(78).for(:date)

	should allow_value(5).for(:size)
	should_not allow_value(0).for(:size)
	should_not allow_value(-3).for(:size)
	should_not allow_value("five").for(:size)
	
   # Need to do the rest with a context
   context "Creating three users, three sharers, three workshops, three subscriptions, and four upvotes" do
     # create the objects I want with factories
    setup do 
		@ryan = FactoryGirl.create(:user, :first_name => "Ryan", :last_name => "Rowe")
		@ryantut = FactoryGirl.create(:sharer, :user => @ryan)
		@barn = FactoryGirl.create(:user, :email => "faraday@example.com")
		@barntut = FactoryGirl.create(:sharer, :user => @barn)
		@eman = FactoryGirl.create(:user, :first_name => "Emannuel", :last_name => "Ruiz", :email => "lavoisier@example.com")
		@emantut = FactoryGirl.create(:sharer, :user => @eman)
		@adobps = FactoryGirl.create(:workshop, :sharer => @barntut)
		@adobau = FactoryGirl.create(:workshop, :description => "Audition", :sharer => @emantut)
		@anima = FactoryGirl.create(:workshop, :category => "Art", :description => "Animation", :sharer => @ryantut)
		# @ryansubps = factorygirl.create(:subscription, :workshop => @adobps, :user => @ryan)
		# @emansubau = factorygirl.create(:subscription, :workshop => @adobau, :user => @eman)
		# @ryansubau = factorygirl.create(:subscription, :workshop => @adobau, :user => @ryan)
		@upvbaps = FactoryGirl.create(:upvote, :user => @barn, :workshop => @adobps)
		@upvryps = FactoryGirl.create(:upvote, :user => @ryan, :workshop => @adobps)
		@upvemps = FactoryGirl.create(:upvote, :user => @eman, :workshop => @adobps)
		@upvryan = FactoryGirl.create(:upvote, :user => @ryan, :workshop => @anima)
    end

     # and provide a teardown method as well
    teardown do
		@ryan.destroy
		@ryantut.destroy
		@barn.destroy
		@barntut.destroy
		@eman.destroy
		@emantut.destroy
		@adobps.destroy
		@adobau.destroy
		@anima.destroy
		# @ryansubps.destroy
		# @emansubau.destroy
		# @ryansubau.destroy
		@upvbaps.destroy
		@upvryps.destroy
		@upvemps.destroy
		@upvryan.destroy
    end
	
	should "list all workshops in the order of how many upvotes they have" do
		assert_equal ["Photoshop", "Animation", "Audition"], Workshop.by_upvotes_size.map{|w| w.description}
		assert_equal [3, 1, 0], Workshop.by_upvotes_size.map{|w| w.upvotes.size}
    end
	
		should "test :for_category scope" do
		assert_equal true, Workshop.for_category("Adobe").include?(@adobps)
		assert_equal true, Workshop.for_category("Adobe").include?(@adobau)
		assert_equal false, Workshop.for_category("Adobe").include?(@anima)
		assert_equal true, Workshop.for_category("Art").include?(@anima)
	end
	
	should "test :for_sharer scope" do
		assert_equal true, Workshop.for_sharer(@barntut.id).include?(@adobps)
		assert_equal false, Workshop.for_sharer(@barntut.id).include?(@adobau)
		assert_equal false, Workshop.for_sharer(@barntut.id).include?(@anima)
		assert_equal true, Workshop.for_sharer(@ryantut.id).include?(@anima)
	end

	# should "distinguish workshops by activeness; can mess up if alphabetical scope doesn't work" do
		# assert Workshop.active.include?(@anima.id)
		# assert Workshop.active.include?(@adobau.id)
		# assert_equal [@adobps], Workshop.inactive{|w| w.id}
		# deny Workshop.inactive.include?(@anima.id)
	# end
	
	# should "not have an active workshop with a past date" do
		# @past_workshop = FactoryGirl.build(:workshop, :description => "Flash Professional", :sharer => @ryantut, :date => 3.days.ago.to_date, :active => true)
		# deny @past_workshop.valid?
	# end
	
	should "ensure each sharer has just one active workshop" do
		biol = FactoryGirl.build(:workshop, :description => "Biology yo", :sharer => @barntut)
		deny biol.valid?
	end

	# should "test that subscriptions and upvotes are deleted when a workshop is deleted" do
		# @rupa = FactoryGirl.create(:user, :first_name => "Rupa", :last_name => "Patel", :email => "rupa@example.com")
		# @rupatut = FactoryGirl.create(:sharer, :user => @rupa)
		# @buddhism = FactoryGirl.create(:workshop, :description => "How to Reach Nirvana", :sharer => @rupatut)
		# @upvbabu = FactoryGirl.create(:upvote, :user => @barn, :workshop => @buddhism)
		# @emansubbu = FactoryGirl.create(:subscription, :user => @eman, :workshop => @buddhism)
		# budddata = [@upvbabu, @emansubbu]
		# @buddhism.destroy
		# @rupa.destroy
		# @rupatut.destroy
		# # assert_equal nil, @rupatut
		# # assert_equal nil, @buddhism
		# deny budddata.include?(@upvbabu)
		# deny budddata.include?(@emansubbu)
	# end
	
   end
end
