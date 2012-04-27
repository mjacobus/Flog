module TagsHelper
  def tags_menu(order = 'name')
    ul = ['<ul class="tags"><li>']
    lis = [link_to(t("All"), root_path)]
    
    Tag.order(order).each do |tag|
      lis << link_to_tag(tag)
    end
    ul << lis.join('</li><li>')
    ul <<"<li></ul>"
    raw ul.join("\n")
  end
  
  def link_to_tag(tag, include_counter = true)
    if include_counter
      link_to(raw("#{tag.name} <span class=\"tag_posts_count\">(#{tag.posts_count})</span>"), "/tag/#{tag.slug}")
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
