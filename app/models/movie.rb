class Movie < ActiveRecord::Base
  paginates_per 12
  has_many :posters, class_name: "Attachment", as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :posters, allow_destroy: true
  has_many :casts
  has_many :actors, through: :casts, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy
  validates :title, presence: true, uniqueness: true, length: { maximum: 150 }
  validates :genre, presence: true, length: { maximum: 30 }
  validates :trailer, presence: true
  validates :description, presence: true
  scope :latest_movies, -> { order ("release_date DESC") }
  scope :featured_movies, -> { where(featured: true) }

  def show_description
    self.description.to_s.html_safe
  end

  def show_trailer
    self.trailer.to_s.html_safe
  end

  def actor_names
    self.actors.pluck(:name).join(', ')
  end

  def duration_in_hour_minutes
   seconds = duration.to_i * 60
   Time.at(seconds).utc.strftime("%H:%M:%S")
  end

  def top_poster(style=:medium)
    profile_picture = posters.first
    profile_picture ? profile_picture.try(:image).url(style) : "#{style.to_s}/missing_poster.png"
  end

  def self.with_category(params)
    params == "latest" ? Movie.latest_movies : Movie.featured_movies
  end

  def get_average_rating
    self.ratings.present? ? self.ratings.average(:score) : 0
  end

  def get_ratings(user)
    user.ratings.for_movie(self).first || user.ratings.build(movie: self)
  end
end
