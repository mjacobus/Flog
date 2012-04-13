require "#{Rails.root}/spec/factories.rb"

PostTag.delete_all
Post.where('title like "title%"').delete_all
Tag.delete_all


@tag1 = Factory(:tag)
@tag2 = Factory(:tag)
@tag3 = Factory(:tag)

1.upto(30) do |n|
  Factory(:post, :publication_date => n.days.ago)
  Factory(:post, :publication_date => n.days.ago, :tags => [@tag1])
  Factory(:post, :publication_date => n.days.ago, :tags => [@tag2])
  Factory(:post, :publication_date => n.days.ago, :tags => [@tag1,@tag2,@tag3])
end




