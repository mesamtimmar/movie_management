ActiveAdmin.register Review do
  permit_params :comment

  index do
    column :id
    column :comment
    column :report_count
    column :created_at
    actions
  end
end
