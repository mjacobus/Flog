require 'spec_helper'

describe TagsHelper do
  before do
    @tag = Factory(:tag)
    @tag2 = Factory(:tag)
    @tag3 = Factory(:tag)
    @post = Factory(:post, :tags => [@tag])
    
    2.times do
      @post = Factory(:post, :tags => [@tag2])
    end
    
    3.times do
      @post = Factory(:post, :tags => [@tag3])
    end
  end

  context "link_to_tag" do
    it "must link to /tag/tag-name and show posts counter" do
      @expected = link_to(raw("#{@tag.name} <span class=\"tag_posts_count\">(#{@tag.posts_count})</span>"),"/tag/#{@tag.slug}")
      helper.link_to_tag(@tag).should == @expected
    end
    
    it "must link to /tag/tag-name with no counter if second param is false" do
      @expected = link_to(@tag.name,"/tag/#{@tag.slug}")
      helper.link_to_tag(@tag,false).should == @expected
    end
  end
  
end
