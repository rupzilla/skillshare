class User < ActiveRecord::Base
    attr_accessible :email, :password, :first_name, :last_name
    has_secure_password

    # Relationship
    has_one :sharer
    has_many :subscriptions
    has_many :workshops, :through => :subscriptions
    has_many :upvotes
    #has_secure_password
        
    # Validations
    validates_uniqueness_of :email
    validates_format_of :email, :with => /^[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))$/i, :message => "is not a valid format"
    
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

      def has_workshop?
          sharer_has_workshop = self.sharer.has_workshop?
          
          if sharer_has_workshop.nil?
            return nil
          else
            return true
          end
      end
   
      
      def workshop_upvotes
        self.upvotes.map{|u| u.workshop.id} 
                 
      end
      
      def workshop_subscriptions
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
      

  
  end