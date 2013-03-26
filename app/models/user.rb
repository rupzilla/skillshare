class User < ActiveRecord::Base
    attr_accessible :email, :password, :password_confirmation
    has_secure_password

    # Relationship

    # Validations
    validates_uniqueness_of :email
    validates_format_of :email, :with => /^[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))$/i, :message => "is not a valid format"
    
    # Other methods
     def proper_name
       "#{first_name} #{last_name}"
     end

  
  end