ActiveAdmin.register Comment, :as => "PostComment" do
  # listing
  index do
    column :id
    column "Post" do |comment|
      comment.post.title
    end
    column :name
    column :email
    column :content
    column :created_at
    
    default_actions
  end 
end
