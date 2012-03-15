ActiveAdmin.register Post do
  
  # form
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs do
      f.input :publish
      f.input :title
      f.input :description
      f.input :file, :as => :file,
        :hint => f.template.image_tag(f.object.file.url(:medium))
    end
    
    f.buttons
  end
  
  # sho
  show do |post|
    panel(post.title) do
      attributes_table_for post do
        row :publish
        
        row "File" do
          img :src => post.file.url(:medium), :title => "Updated at: #{post.file_updated_at}"
        end
        
        row :description
        row :created_at
        row :updated_at
      end
      
    end
  end
  
  # index
  
  # listing
  index do
    column :publish
    column "File" do |post|
      div :class => "logo thumb" do
        img :src => post.file.url(:thumb), :alt => post.title, :title => post.title
      end
    end
    
    column :title
    column :created_at
    column :updated_at
    column :file_updated_at
    
    default_actions
  end
  
end
