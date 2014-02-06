ActiveAdmin.register Attendee do
  permit_params :event_id, :user_id

  index do
    selectable_column
    column :id
    column :event
    column :user
    default_actions
  end
end