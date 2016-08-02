class Actor < ActiveRecord::Base
  has_many :casts
  has_many :movies, through: :casts, dependent: :destroy
  has_many :pictures, class_name: "Attachment", as: :attachable, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validates :gender, presence: true, length: { maximum: 10 }

  accepts_nested_attributes_for :pictures, allow_destroy: true, reject_if: proc { |attributes| attributes['image'].blank? }

  def movies_worked_in(params)
    movies.includes(:ratings, :posters).page(params[:page])
  end

  def profile_picture(style=:medium)
    profile_picture = pictures.first
    profile_picture ? profile_picture.image.url(style) : "#{style.to_s}/missing.png"
  end
end
