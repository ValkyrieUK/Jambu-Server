ActiveAdmin.register User do
  permit_params :provider, :username, :image_url, :image_thumbnail, :full_name, :uid, :colour
end
