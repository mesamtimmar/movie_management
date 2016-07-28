class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  TOKEN = 'ad2323wmkljl2kj2lj3l2l3k'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_one :attachment, as: :attachable
  accepts_nested_attributes_for :attachment
  has_many :reviews, dependent: :destroy
  has_many :reported_reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, class_name: 'Movie', through: :favorites, source: :movie

  validates :email, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :full_name, presence: true, length: { maximum: 50 }

  def show_profile_picture(style = :original)
    profile_picture = self.attachment
    profile_picture ? profile_picture.try(:image).url(style) : "#{style.to_s}/missing.png"
  end

  def self.get_favorite_movies(user,params)
    user.favorite_movies.includes(:ratings, :posters).page(params[:page])
  end
end
