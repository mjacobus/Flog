module TagsHelper
  def tags_menu(order = 'title')
    # ul = '<ul class="tags">'
    # Tags.order(order).each do |tag|
    #   ul << "<li>#{link_to_tag(tag)}</li>"
    # end
    # ul <<"</ul>"
    # raw ul
  end
  
  def link_to_tag(tag)
    link_to("#{tag.name} (#{tag.posts_count})", "/tag/#{tag.slug}")
  end
  
  def link_to_tags(tags)
    links = []
    tags.each do |tag|
      links << link_to_tag(tag)
    end
    raw links.join(' | ')
  end
end
