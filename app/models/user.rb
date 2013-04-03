class User < ActiveRecord::Base
    attr_accessible :email, :password, :password_confirmation
    has_secure_password

    # Relationship
    has_one :sharer
    has_many :subscriptions
    has_many :workshops, :through => :subscriptions
    has_many :upvotes
        
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
      
      

  
  end