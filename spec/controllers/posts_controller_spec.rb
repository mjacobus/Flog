require 'spec_helper'

describe PostsController do
  before do
    # considering today was 2012-03-19
    1.upto(15) do |day|
      # 15 1 year old posts + 15 unpublilshed
      Factory(:post, :publication_date => "2011-03-#{day}")
      Factory(:post, :publication_date => "2011-03-#{day}", :publish => false)
      # 15 2 months old
      Factory(:post, :publication_date => "2012-01-#{day}")
      # + 30 2 months old posts  + 15 unpublished
      Factory(:post, :publication_date => "2012-02-#{day}")
      Factory(:post, :publication_date => "2012-02-#{day}")
      Factory(:post, :publication_date => "2012-02-#{day}", :publish => false)
      
      # 15 posts in the future        
      Factory(:post, :publication_date => 1.month.from_now)
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
