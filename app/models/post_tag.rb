class PostTag < ActiveRecord::Base
  self.table_name =  :posts_tags
  belongs_to :post
  belongs_to :tag


  after_save :update_tag_posts_count
  
  # not working
  # http://stackoverflow.com/questions/9911078/activerecrod-has-many-through-dependent-destroy-sql-is-not-correct
  after_destroy :update_tag_posts_count
  
  def update_tag_posts_count
    tag.posts_count = tag.posts.count
    tag.save
  end
end
