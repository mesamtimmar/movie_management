class Attachment < ActiveRecord::Base
  has_attached_file :image,
                    styles: {
                              medium: "150x200#",
                              thumb: "100x100>"
                            },
                    default_url: ":style/missing.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to :attachable, polymorphic: true
end
