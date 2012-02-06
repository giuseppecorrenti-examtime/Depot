class User < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false
  has_one :cart,  :dependent => :destroy
  has_and_belongs_to_many :roles
  after_create :add_default_role
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
  def role?(role)  
    roles.any? { |r| r.name.underscore.to_sym == role }
  end  
  
  def add_default_role
    roles << Role.find_by_name('customer') 
  end
  
end
