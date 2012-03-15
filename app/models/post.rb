class Post < ActiveRecord::Base
  has_attached_file :file,
    :styles => {
      :original => "1072x712>",
      :medium => "536x356>",
      :small => "268x178>",
      :thumb => "134x89>",
    }

  validates_attachment_presence :file
  validates_attachment_content_type :file, :content_type => ['image/jpeg', 'image/png']
  # not working
  validates_attachment_size :file, :less_than => 5.megabytes
end
