ActiveAdmin.register Activity do
  permit_params :user_id, :action, :name, :argument
end