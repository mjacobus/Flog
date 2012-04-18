class Comment < ActiveRecord::Base
  belongs_to :post
  
  validates :name, :presence => true
  validates :email, :presence => true
  validates :content, :presence => true
  validates :post, :presence => true
end
