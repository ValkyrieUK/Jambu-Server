ActiveAdmin.register Attendee do
  permit_params :event_id, :attendee_id
end