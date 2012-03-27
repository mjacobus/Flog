class PostTag < ActiveRecord::Base
  self.table_name =  :posts_tags
  belongs_to :post
  belongs_to :tag
  
  # http://stackoverflow.com/questions/2170108/activerecordhasmanythroughassociationnotfounderror-in-usercontrollerwelcome
  # http://stackoverflow.com/questions/632742/how-can-i-avoid-running-activerecord-callbacks
  after_save do
    tag.posts_count = tag.posts.count
    tag.save
  end
  
end
