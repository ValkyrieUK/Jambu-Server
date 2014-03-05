ActiveAdmin.register DeviceToken do
  permit_params :user_id, :os, :token
end
