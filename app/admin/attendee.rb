ActiveAdmin.register Attendee do
  permit_params :event_id, :user_id, :going?

  index do
    selectable_column
    column :id
    column :event
    column :user
    column :created_at
    default_actions
  end
end
