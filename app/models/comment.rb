class Comment < ActiveRecord::Base
  belongs_to :post, :counter_cache => true
  
  validates :name, :presence => true
  validates :email, :presence => true
  validates :content, :presence => true
  validates :post, :presence => true
end
