class Tag < ActiveRecord::Base
  has_many :post_tags
  has_many :posts, :through => :post_tags

  validates :name, 
    :presence => true, 
    :uniqueness => {:case_sensitive => false}
    
  validates :slug, 
    :presence => true, 
    :uniqueness => {:case_sensitive => false}  
  
  # updates posts_count
  # if posts_count == 0, the tag must be destroyed  
  def update_posts_count
    count = posts.count
    if count > 0 
      self[:posts_count] = count
      save
    else
      destroy
    end  
  end
end
