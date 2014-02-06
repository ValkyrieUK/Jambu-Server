ActiveAdmin.register Event do
  permit_params :title, :description, :user_id, :time_of_event

  index do
    selectable_column
    column :id
    column :user
    column :title
    column :created_at
    default_actions
  end
end