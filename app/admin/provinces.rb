# app/admin/provinces.rb
ActiveAdmin.register Province do
    permit_params :name, :pst, :gst, :hst
  
    index do
      selectable_column
      id_column
      column :name
      column :pst
      column :gst
      column :hst
      actions
    end
  
    form do |f|
      f.inputs "Province Details" do
        f.input :name
        f.input :pst
        f.input :gst
        f.input :hst
      end
      f.actions
    end
  end
  