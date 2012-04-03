require 'spec_helper'

describe Tag do
  context "Validation" do
    %w(name slug).each do |attr|
      # required fields
      it "must have a #{attr}" do
        @tag = Factory.build(:tag)
        @tag.should be_valid
        @tag.send("#{attr}=", '')
        @tag.should_not be_valid
        @tag.should have(1).errors_on(attr)        
      end
      
      # unique fields
      it "must have a #{attr}" do
        @tag = Factory(:tag)
        @new_tag = Factory.build(:tag)
        @new_tag.should be_valid
        @new_tag.send("#{attr}=", @tag.send("#{attr}"))
        @new_tag.should_not be_valid
        @new_tag.should have(1).errors_on(attr)        
      end
    end
  end
  
  context "posts count cache" do
    before(:each) do
      @tag = Factory(:tag)
      1.upto(10) do
        @post = Factory(:post)
        @post.tags << @tag
        @post.save!
      end
    end
    
    it "should keep count of posts" do
      @tag.posts_count.should == 10
    end
    
    it "should increase count of posts when a tag is added to a post" do
      @post = Factory(:post)
      @post.tags << @tag
      @post.save
      @tag.posts_count.should == 11
    end
    
    it "should decrease count of posts a tag post is destroyed" do
      @post.destroy
      @tag.posts_count.should == 9
    end
    
    it "should destroy tag after destroying all of its posts" do
      lambda {
        @tag.posts.each do |post|
          post.destroy
        end
      }.should change(Tag, :count).by(-1)
    end
  end
end
