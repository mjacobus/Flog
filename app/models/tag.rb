class Tag < ActiveRecord::Base
  validates :name, 
    :presence => true, 
    :uniqueness => {:case_sensitive => false}
    
  validates :slug, 
    :presence => true, 
    :uniqueness => {:case_sensitive => false}  
end
