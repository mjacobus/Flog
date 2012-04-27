class PostsController < ApplicationController
  
  layout "posts"
  
  def index
    page = params[:page]  || 1
    per  = params[:limit] || 10
    @posts = Post.published(params).page(page).per(per)
  end
  
  def show
    @post = Post.find_by_slug(params[:slug])
    @post.comments.build
  end
end
