class User < ActiveRecord::Base
    attr_accessible :email, :password, :password_confirmation
    has_secure_password
	
	# Callbacks
#	before_save :no_double_subbing

    # Relationship
    has_one :sharer
    has_many :subscriptions
    has_many :workshops, :through => :subscriptions
    has_many :upvotes
        
    # Validations
	validates_presence_of :email
    validates_uniqueness_of :email
    validates_format_of :email, :with => /^[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))$/i, :message => "is not a valid format"
	validates_presence_of :first_name
	validates_presence_of :last_name
	
#	validate :no_double_upvoting
	validate :no_double_subbing
    
    # Other methods
     def proper_name
       "#{first_name} #{last_name}"
     end
     
     def is_sharer?
       is_a_sharer = self.sharer
       
       if is_a_sharer.nil?
         return nil
      else
        return true
       end
     end
	 
	 def major
		unless self.sharer.nil?
			self.sharer.major
		end
	 end

      def has_workshop?
          sharer_has_workshop = self.sharer.has_workshop?
          
          if sharer_has_workshop.nil?
            return nil
          else
            return true
          end
      end
      
      # def match_id
      #      for user.id in upvotes 
      #        id1 = user.id
      #        if id1 = self.id
      #          return true
      #        else
      #          return nil
      #        end
      #      end
        
      def workshop_upvotes
        # if match_id true
        #          self.upvotes.map{|u| u.workshop.id}
        #        else
        #          return nil
        #        end
        #      end
        
      
        self.upvotes.map{|u| u.workshop.id} 
                 
      end
      
      def workshop_subscriptions
        # if match_id true
        #          self.upvotes.map{|u| u.workshop.id}
        #        else
        #          return nil
        #        end
        #      end
        
      
        self.subscriptions.map{|s| s.workshop.id} 
                 
      end
      
      def get_workshop_subscription(workshop_id)
        subscriptions = self.subscriptions
        subscriptions.each do |sub|
          if sub.workshop.id == workshop_id
            return sub
          end
        end
        nil
      end
      
      def get_workshop_upvote(workshop_id)
        upvotes = self.upvotes
        upvotes.each do |up|
          if up.workshop.id == workshop_id
            return up
          end
        end
        nil
      end
      
	private
	  def no_double_upvoting
		upvs = self.upvotes
		wshops = Workshop.all
		for w in wshops do
			unless upvs.for_workshop(w.id).size == 0 then
				errors.add(:id, "You cannot upvote a workshop more than once.")
			end
		# y = 0
		# for i in 0..(upvs.size - 1) do
			# upvs.each do |e|
				# if upvs[i].workshop_id == e.workshop_id
					# y = y + 1
				# end
			# end
			# if y >= 1
				# errors.add_to_base("You cannot upvote a workshop more than once.")
			# end
		end
	  end
	  
	  def no_double_subbing
		wshops = Workshop.all
		for w in wshops do
			unless (Subscription.for_user(self.id).for_workshop(w.id).size) == 0 then
				errors.add(:id, "You cannot upvote a workshop more than once.")
			end
		end
	  end
	  
  end