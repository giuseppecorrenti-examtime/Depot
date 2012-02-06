class Role < ActiveRecord::Base  
  # Associations
  has_and_belongs_to_many :users
  
  # Validations
  validates_presence_of :name 
  validates_uniqueness_of :name
  
end
