class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
    
    if user.role? :admin      
      can :manage, :all    
    elsif user.role? :customer
      can :read, [Product,Role,User]
      can :manage, LineItem
      can :manage, @cart, {:user_id => user.id}     
    end
      # A Customer has to be able to read Products and Roles      
      # A Customer has to be able to manage his own cart
    
  end  
  
end