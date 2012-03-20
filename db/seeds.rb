require "#{Rails.root}/spec/factories.rb"

0.upto(137) do |n|
  Factory(:post, :publication_date => n.days.ago)
end
