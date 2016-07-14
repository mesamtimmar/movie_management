class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_one :attachment, as: :attachable
  accepts_nested_attributes_for :attachment
  has_many :reviews, dependent: :destroy
  has_many :reported_reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy

  def show_profile_picture(style = :original)
    profile_picture = self.attachment
    profile_picture ? profile_picture.try(:image).url(style) : "#{style.to_s}/missing.png"
  end
end
