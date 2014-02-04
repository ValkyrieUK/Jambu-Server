ActiveAdmin.register User do
  permit_params :provider, :username, :image_url, :full_name, :uid, :colour
end
