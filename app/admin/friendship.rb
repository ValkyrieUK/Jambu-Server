ActiveAdmin.register Friendship do
  permit_params :user_id, :friend_id  

  index do
    selectable_column
    column :id
    column :user_id
    column :friend_id
    column :created_at
    default_actions
  end
end
