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
  
  context "scope published" do
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
      end
    end
    
    it "should get 16 valid posts" do
      Post.published.length == 15
    end
  end
end
