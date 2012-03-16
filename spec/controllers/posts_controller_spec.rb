require 'spec_helper'

describe PostsController do
  before do
    # 10 posts per page
    # 21 posts
    # 16 with publication date <= today
    # 15 with publication date <= today AND publish == true
    # 10 posts 1st page
    # 5 posts 2nd page
    Factory(:post, :publish => false)
    1.upto(20) do |n|
      Factory(:post, :publication_date => 15.days.ago + n.days)
    end
  end
  
  context "GET #index" do
    it "should be success" do
      get :index
      response.should be_success
    end
    
    it "should assign @posts" do
      get :index
      assigns(:posts)
    end
    
    it "should have @posts.length == 10" do
      get :index
      assigns(:posts).length.should == 10
    end
  end
end
