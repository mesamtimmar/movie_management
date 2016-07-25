ActiveAdmin.register User do
  permit_params :email, :password
  actions :all, except: [:edit, :destroy]

  index do
    column :email
    column 'Image' do |user|
      image_tag(user.attachment.image.url(:thumb)) if user.attachment
    end
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
    end
    f.actions
  end
end
