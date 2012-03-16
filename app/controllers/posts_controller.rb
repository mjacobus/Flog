class PostsController < ApplicationController
  
  def index
    @posts = Post.published.page(1).per(10)
  end
end
