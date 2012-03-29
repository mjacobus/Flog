class PostTag < ActiveRecord::Base
  self.table_name =  :posts_tags
  belongs_to :post
  belongs_to :tag

  after_save    :update_tag_posts_count
  after_destroy :update_tag_posts_count

  def update_tag_posts_count
    tag.update_posts_count
  end
  
end
