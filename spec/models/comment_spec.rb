require 'spec_helper'

describe Comment do
  context "Validation" do
    before(:each) do
      @comment = Factory(:comment)
    end
    
    %w(email name content post).each do |field|
      it "should have a #{field}" do
        ["", " ", nil].each do |value|
          @comment.send("#{field}=",nil)
          @comment.should_not be_valid
          @comment.should have(1).errors_on(field)  
        end
      end
    end
    
  end
end
