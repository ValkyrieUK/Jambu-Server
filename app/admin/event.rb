ActiveAdmin.register Event do
  permit_params :title, :description, :user_id
 index do
    selectable_column
    column :id
    column :user_id
    column :title
    column :created_at
  end
end