require 'spec_helper'

describe Post do
  context "Validation" do
    # required fields
    %w(title slug file_file_name).each do |attr|
      it "must have a #{attr}" do
        @post = Factory.build(:post)
        @post.should be_valid
        @post.send("#{attr}=", '')
        @post.should_not be_valid
        @post.should have(1).errors_on(attr)        
      end
    end
    
    # file is required
    it "must have a file" do
        @post = Factory.build(:post)
        @post.should be_valid
        @post.file = nil
        @post.should_not be_valid
        @post.should have(1).errors_on(:file)        
    end
    
    # unique fields
    it "must have a unique slug" do
      @post = Factory(:post)
      @new_post = Factory.build(:post)
      @new_post.slug = @post.slug.upcase
      @new_post.should_not be_valid
      @new_post.should have(1).errors_on(:slug)
    end
  end
  
  context "Slug" do
      {
        'A Title' => 'a-title',
        'My Name is Marcelo   Dude!' => 'my-name-is-marcelo-dude',
      }.each do |title, slug|
        it "when title is '#{title}' slug must be '#{slug}'" do
          @post = Factory(:post)
          @post.title = title
          @post.slug.should == slug
        end
      end 
  end
  
  context "published() with no params" do
    before do
      # 10 posts per page
      # 21 posts
      # 16 with publication date <= today
      # 15 with publication date <= today AND publish == true
      # 10 posts 1st page
      # 5 posts 2nd page
      Factory(:post, :publish => false)
      1.upto(20) do |n|
        Factory(:post, :publication_date => 15.days.ago + n.days)
        Factory(:post, :publication_date => n.days.from_now)
      end
    end
    
    it "should get 15 valid posts" do
      Post.published.length == 15
    end
  end
  
  context "published() with params" do
     context "with date" do
       before do
        # considering today was 2012-03-19
        1.upto(15) do |day|
          # 15 1 year old posts + 15 unpublilshed
          Factory(:post, :publication_date => "2011-03-#{day}")
          Factory(:post, :publication_date => "2011-03-#{day}", :publish => false)
          # 15 2 months old
          Factory(:post, :publication_date => "2012-01-#{day}")
          # + 30 2 months old posts  + 15 unpublished
          Factory(:post, :publication_date => "2012-02-#{day}")
          Factory(:post, :publication_date => "2012-02-#{day}")
          Factory(:post, :publication_date => "2012-02-#{day}", :publish => false)
          
          # 15 posts in the future        
          Factory(:post, :publication_date => 1.month.from_now)
        end
      end
      
      it "list(:year => '2011')).length should be 15" do
        Post.published(:year => '2011').length.should == 15 
      end
      
      it "list(:year => '2012', :month => 02)).length should be 30" do
        Post.published(:year => '2012', :month => '02').length.should == 30
      end
      
      it "list(:year => '2012', :month => 02, :day => '02')).length should be 16" do
        Post.published(:year => '2012', :month => '02', :day => '02').length.should == 2
      end
     end
    
    context "with tag" do
      before do
        @tag  = Factory(:tag)
        @tag2 = Factory(:tag)
        1.upto(15) do
          Factory(:post)
          Factory(:post, :tags => [@tag])
          Factory(:post, :tags => [@tag, @tag2])
        end
      end
      
      it "must find published params by tag" do
        Post.published(:tag => @tag.slug).length.should == 30
        Post.published(:tag => @tag2.slug).length.should == 15
      end
    end
  end
  # publish with params
  
  context "tags" do
    it "can save post with text tags" do
      lambda{
        lambda {
          attrs = Factory.attributes_for(:post)
          attrs[:tags_as_string] = "Tag, tag 2, e uma outra tag"
          Post.create!(attrs)
        }.should change(Post,:count).by(1)
      }.should   change(Tag, :count).by(3)
    end
    
    it "can update tags as string" do
      @post = Factory(:post)
      @post.tags_as_string = "one, two, three"
      @post.save!
      
      lambda{
        @post.tags_as_string = "one, two, three, four"
      }.should change(Tag, :count).by(1)
    end
    
    it "can get tags as string" do
      @tag =  Factory(:tag, :name => "a tag")
      @tag2 = Factory(:tag, :name => "another tag")
      @tag3 = Factory(:tag, :name => "yet another tag")
      
      @post = Factory(:post)
      @post.tags << @tag
      @post.tags << @tag2
      @post.tags << @tag3
            
      @post.tags_as_string.should == "a tag, another tag, yet another tag"
    end
  end
  
  
  
  
#  context "nested attributes" do
#    context "tags" do
#      before(:each) do
#        @tag =  Factory(:tag)
#        @tag2 = Factory(:tag)
#        @post = Factory(:post, :tags =>[@tag, @tag2])
#      end
#    
#      it "must create post with tags" do
#        attrs = Factory.attributes_for(:post)
#        attrs[:tags_attributes] = {
#          1 => Factory.attributes_for(:tag),
#          2 => Factory.attributes_for(:tag),
#          3 => {:name => ''}
#        }
#        
#        lambda{
#          lambda{
#            Post.create(attrs)
#          }.should change(Post, :count).by(1)
#        }.should change(Tag, :count).by(2)
#      end
#      
#      it "must delete post tags" do
#        attributes = @post.attributes
#        attributes[:tags_attributes] = {
#          1 => {:id => @tag.id, :_destroy => true}
#        }
#        
#        lambda {
#          @post.update_attributes(attributes)
#        }.should change(Tag, :count).by(-1)
#      end
#      
#      it "must create new tag on update" do
#        attrs = @post.attributes
#        attrs[:tags_attributes] = {1 => Factory.attributes_for(:tag)}

#        lambda{
#          @post.update_attributes(attrs)
#        }.should change(Tag, :count).by(1)
#      end
#    end
#  end  
end
