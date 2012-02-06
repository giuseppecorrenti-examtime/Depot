class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
    
    if user.role? :admin      
      can :manage, :all    
    elsif user.role? :customer
      # A Customer has to be able to read Products and Roles
      can :read, [Product,Role]  
      # A Customer has to be able to manage his own cart    
      can :create, Cart
      can :read, Cart do |cart|
        cart.id == user.cart.id
      end
      can :update, Cart do |cart|
        cart.id == user.cart.id
      end
      can :destroy, Cart do |cart|
        puts "===================" + user.inspect
        puts "\n"
        puts "===================" + user.cart.inspect
        cart.id == user.cart.id              
      end
      
      
      # A Customer has to be able to manage the line items of his own cart   
      can :create, LineItem  
      can :read, LineItem do |item|
        item.cart_id == user.cart.id
      end  
      can :update, LineItem do |item|
        item.cart_id == user.cart.id
      end 
      can :destroy, LineItem do |item|
        puts "===================" + item.inspect
        puts "\n"
        puts "===================" + user.cart.inspect
        item.cart_id == user.cart.id
      end         
     
    end         
    
  end  
  
end