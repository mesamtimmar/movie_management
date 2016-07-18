ActiveAdmin.register Actor do
  permit_params :name , :gender, :biography

  index do
    column :id
    column :name
    column :gender
    column :biography
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :gender
      f.input :biography
      end
    f.actions
  end
end
