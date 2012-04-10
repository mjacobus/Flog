module TagsHelper
  def tags_menu(order = 'name')
    ul = ['<ul class="tags">']
    Tag.order(order).each do |tag|
      ul << "<li>#{link_to_tag(tag)}</li>"
    end
    ul <<"</ul>"
    raw ul.join("\n")
  end
  
  def link_to_tag(tag, include_counter = true)
    if include_counter
      link_to("#{tag.name} (#{tag.posts_count})", "/tag/#{tag.slug}")
    else
      link_to(tag.name, "/tag/#{tag.slug}")
    end  
  end
  
  def link_to_tags(tags)
    links = []
    tags.each do |tag|
      links << link_to_tag(tag, false)
    end
    raw links.join(', ')
  end
end
