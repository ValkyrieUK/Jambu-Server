ActiveAdmin.register User do
  permit_params :provider, :username, :image_url, :image_thumbnail, :full_name, :uid, :colour

  index do
    selectable_column
    column :id
    column :uid
    column :username
    column :full_name
    column :image_url
    column :colour
    default_actions
  end
end
