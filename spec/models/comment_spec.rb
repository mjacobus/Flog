require 'spec_helper'

describe Comment do
  context "Validation" do
    before(:each) do
      @comment = Factory(:comment)
    end
    
    %w(email name content post).each do |field|
      it "should have a #{field}" do
        ["", " ", nil].each do |value|
          @comment.send("#{field}=",nil)
          @comment.should_not be_valid
          @comment.should have(1).errors_on(field)  
        end
      end
    end
  end
  
  context "comments_count cache" do
    before(:each) do
      @post = Factory(:post)
      1.upto(10) do |i|
        @comment = Factory(:comment, :post => @post)
      end
    end
    
    it "@post.comments_count should be 10" do
      @post.reload
      @post.comments_count.should == 10
    end
    
    it "@post.comments_count should decrease when a comment is destroyed" do
      lambda {
        @comment.destroy  
      }.should change(Comment, :count).by(-1)
      @post.reload
      @post.comments_count.should == 9
    end
    
    it "@post.comments_count should increase when a comment is added" do
      lambda {
        Factory(:comment, :post => @post) 
      }.should change(Comment, :count).by(1)
      @post.reload
      @post.comments_count.should == 11
    end
  end
  
  context "when a post is destroyed" do
    before(:each) do
      @post = Factory(:post)
      1.upto(10) do |i|
        @comment = Factory(:comment, :post => @post)
      end
    end
    
    it "must destroy the comments along" do
      lambda{
        lambda{
          @post.destroy    
        }.should change(Post,:count).by(-1)
      }.should change(Comment,:count).by(-10)
    end
  end

end
