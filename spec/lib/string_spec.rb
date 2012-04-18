# encoding: utf-8
require 'spec_helper'

describe String do
  {
    "a" => %w(á à â ã ä Á À Ã Â Ä),
    "e" => %w(ê ẽ è é ë Ê Ẽ È É Ë),
    "i" => %w(î ĩ ì í ï Î Ĩ Ì Í Ï),
    "o" => %w(ô õ ò ó ö Ô Õ Ò Ó Ö),
    "u" => %w(û ũ ù ú ü Û Ũ Ù Ú Ü),
    "c" => %w(ç Ç),
    "double-spaces" => [" double-spaces  "] 
  }.each do |slugged, values|
    values.each do |value|
      context "'#{value}'.to_slug" do
        it "should == '#{slugged}'" do
          value.to_slug.should == slugged          
        end
      end      
    end
  end
end