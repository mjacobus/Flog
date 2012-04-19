class CommentsController < ApplicationController
  layout "posts"
  
  def create
    attributes = params[:comment]
    @post = Post.find(attributes[:post_id])
    @comment = @post.comments.build(attributes)
    
    if @comment.save
      redirect_to post_path(@post.slug)
    else
      render 'posts/show'    
    end
  end
end
