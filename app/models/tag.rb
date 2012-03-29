class Tag < ActiveRecord::Base
  has_many :post_tags, :dependent => :destroy
  has_many :posts, :through => :post_tags

  validates :name, 
    :presence => true, 
    :uniqueness => {:case_sensitive => false}
    
  validates :slug, 
    :presence => true, 
    :uniqueness => {:case_sensitive => false}  
    
  def update_posts_count
    posts_count = posts.count
    save
  end
end
