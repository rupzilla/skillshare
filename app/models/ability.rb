class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
	user ||= User.new # guest user (not logged in)
	can :manage, User do |u|
		u.id == user.id
	end	
	can :delete, Subscription do |su|
		su.user_id == user.id
	end
	can :delete, Upvote do |up|
		up.user_id == user.id
	end
	if user.is_sharer?
		can :manage, Sharer do |s|
			s.user_id == user.id
		end
		can :manage, Workshop do |w|
			w.sharer.user_id == user.id
		end
	end
	# if user.sharer_id 
		# can :update, Employee do |emp|
			# emp.current_assignment.store_id == user.employee.current_assignment.store_id
		# end
		# can :manage, Shift#.by_store(user.employee.current_assignment.store_id)
# #		can :manage, Shift do |shift|
# #			shift.assignment.store_id == user.employee.current_assignment.store_id
# #		end
	# elsif user.role? :employee
		# can :read, Employee do |emp|
			# emp.id == user.employee_id
		# end
		# can :read, Shift do |shift|
			# shift.assignment_id == user.employee.current_assignment.id
		# end	
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
