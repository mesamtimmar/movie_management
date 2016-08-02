ActiveAdmin.register Actor do
  permit_params :name , :gender, :biography, pictures_attributes: [:id, :image, :_destroy]

  index do
    column :id
    column :name
    column :gender
    column :biography
    column 'Picture' do |actor|
      image_tag(actor.profile_picture(:thumb))
    end
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :picture do
        div do
          actor.pictures.each do |picture|
            div do
              image_tag(picture.image.url(:thumb))
            end
          end
        end
      end
      row :name
      row :gender
      row :biography
    end
  end


  form do |f|
    f.inputs do
      f.input :name
      f.input :gender
      f.input :biography
      f.has_many :pictures, heading: 'Pictures', new_record: 'Add Picture' do |attachment|
        attachment.input :image, hint: attachment.template.image_tag(attachment.object.image.url(:medium)), allow_destroy: true
        attachment.input :_destroy, as: :boolean, required: :false, label: 'Remove Picture'
      end
    end
    f.actions
  end
end
