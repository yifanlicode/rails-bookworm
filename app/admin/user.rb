# app/admin/user.rb
ActiveAdmin.register User do

  permit_params :username, :email, :is_admin, :other_attribute

  index do
    selectable_column
    id_column
    column :email
    column :is_admin
    actions
  end

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :is_admin
    end
    f.actions
  end
end
