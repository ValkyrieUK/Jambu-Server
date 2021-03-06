ActiveAdmin.register DeviceToken do
  permit_params :user_id, :os, :token

  index do
    selectable_column
    column :user
    column :os
    default_actions
  end
end
