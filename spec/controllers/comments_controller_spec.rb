require 'spec_helper'

describe CommentsController do
  before do
    @post = Factory(:post)
  end

  def valid_params
    attributes = Factory.attributes_for(:comment)
    attributes[:post_id] = @post.id
    {:comment => attributes}
  end
  
  describe "POST /create" do
    context "with valid params" do
      it "should be success" do
        post :create, valid_params
        response.should redirect_to post_path(@post.slug)
      end
      
      it "should create comment" do
        lambda{
          post :create, valid_params
        }.should change(Comment, :count).by(1)
      end
    end
    
    context "with invalid params" do
      it "must rerender the post form" do
        Comment.any_instance.stub(:valid?).and_return(false)
        post :create, {:comment => {:post_id => @post.id}}
        response.should render_template("posts/show")
      end
    end
  end
end
