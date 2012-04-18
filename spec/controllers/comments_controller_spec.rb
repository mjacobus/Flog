require 'spec_helper'

describe CommentsController do
  def valid_params
    Factory.attributes_for(:comment)
  end
  
  describe "POST /create" do
    context "with valid params" do
      it "should be success" do
        post :create, valid_params
        response.should be_success  
      end
      
      it "should create comment" do
        lambda{
          post :create, valid_params
        }.should change(Comment, :count).by(1)
      end
    end
    
    context "with invalid params" do
      pending "Finish this test"
    end
  end
end
