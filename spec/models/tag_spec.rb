require 'spec_helper'

describe Tag do
  context "Validation" do
    %w(name slug).each do |attr|
      # required fields
      it "must have a #{attr}" do
        @tag = Factory.build(:tag)
        @tag.should be_valid
        @tag.send("#{attr}=", '')
        @tag.should_not be_valid
        @tag.should have(1).errors_on(attr)        
      end
      
      # unique fields
      it "must have a #{attr}" do
        @tag = Factory(:tag)
        @new_tag = Factory.build(:tag)
        @new_tag.should be_valid
        @new_tag.send("#{attr}=", @tag.send("#{attr}"))
        @new_tag.should_not be_valid
        @new_tag.should have(1).errors_on(attr)        
      end
      
    end
  end
end
