ActiveAdmin.register Post do

  # form
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.object.publication_date = Time.now if f.object.new_record?
    f.inputs "Flog post" do
      f.input :publish
      f.input :publication_date
      f.input :title
      f.input :description
      f.input :file, :as => :file,
        :hint => f.template.image_tag(f.object.file.url(:medium))
    end
    
    f.inputs "Meta info" do
      f.input :tags_as_string
    end
    
    f.buttons
  end
  
  # show
  show do |post|
    panel(post.title) do
      attributes_table_for post do
        row :publish
        row :publication_date
        
        row "File" do
          img :src => post.file.url(:medium), :title => "Updated at: #{post.file_updated_at}"
        end
        
        row :description
        row :slug
        row :tags do
          post.tags_as_string
        end
        row :created_at
        row :updated_at
      end
      
    end
  end
  
  # index
  index do
    column :publish
    column :publication_date
    column "File" do |post|
      div :class => "logo thumb" do
        img :src => post.file.url(:thumb), :alt => post.title, :title => post.title
      end
    end
    
    column :title
    column :slug
    column :tags_as_string, :sortable => false
    column :created_at
    column :updated_at
    column :file_updated_at
    
    default_actions
  end
  
end
