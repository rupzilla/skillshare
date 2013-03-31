class User < ActiveRecord::Base
    attr_accessible :email, :password, :password_confirmation
    has_secure_password

    # Relationship
    has_one :sharer
    has_many :subscriptions
    has_many :workshops, :through => :subscriptions

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
      

  
  end