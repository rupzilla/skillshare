class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
	user ||= User.new # guest user (not logged in)
  end
  
  def proper_name
    "#{first_name} #{last_name}"
  end
end
