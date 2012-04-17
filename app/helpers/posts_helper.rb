module PostsHelper

  # set the title of the listed posts
  def set_post_list_title
    if @posts.size > 0 
      if params[:tag]
        #tag title
        title("#{@posts.first.tags.first.name}") 
      elsif params[:year]
        # time title
        if params[:day]
          date = Date.new(params[:year].to_i,params[:month].to_i,params[:day].to_i)
          title("#{date.to_formatted_s(:long_ordinal)}")
        elsif params[:month]
          title("#{params[:year]}/#{params[:month]}")
        else
          title("#{params[:year]}")
        end
      else
        title("All posts")  
      end
    else
      title "No posts found"
    end
  end
  
  # format post description
  def description(post) 
    simple_format(post.description)
  end
  
end
