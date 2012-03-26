Factory.define :post do |f|
  f.sequence(:title) {|n| "title #{n}"}
  f.sequence(:description){|n| "description#{n}"}
  f.sequence(:slug) {|n| "title-#{n}"}
  f.file_file_name    "File.png"
  f.file_content_type "image/png"
  f.file_file_size    1000
  f.file_updated_at   Time.now
  f.publish           true
  f.sequence(:publication_date) {|n| 2.weeks.ago + n.days}
end

Factory.define :tag do |f|
  f.sequence(:name) {|n| "tag #{n}"}
  f.sequence(:slug) {|n| "tag-#{n}"}
end
