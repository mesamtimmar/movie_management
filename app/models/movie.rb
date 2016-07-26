class Movie < ActiveRecord::Base

  DEFAULT_SEARCH_FILTER = { approved: true }
  DEFAULT_SEARCH_ORDER = 'updated_at DESC'
  GENRE = %w(Crime Action Thriller Romance Horror)
  NUMBER_OF_MOVIES_IN_CATEGORY = 4

  include ThinkingSphinx::Scopes
  paginates_per 12

  has_many :posters, class_name: "Attachment", as: :attachable, dependent: :destroy
  has_many :casts
  has_many :actors, through: :casts, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :favorites, dependent: :destroy

  accepts_nested_attributes_for :posters, allow_destroy: true

  validates :title, presence: true, uniqueness: true, length: { maximum: 150 }
  validates :genre, presence: true, length: { maximum: 30 }
  validates :trailer, presence: true
  validates :description, presence: true

  scope :latest_movies, -> { order ("release_date DESC") }
  scope :featured_movies, -> { where(featured: true).order ('updated_at DESC') }
  scope :top_rated, -> { joins(:ratings).group('ratings.movie_id').order('AVG(ratings.score) DESC') }
  scope :approved, -> { where(approved: true) }

  sphinx_scope(:latest) {
    { order: 'release_date DESC' }
  }
  sphinx_scope(:approved) {
    { with: { approved: true } }
  }
  sphinx_scope(:featured) {
    { with: { featured: true} }
  }

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
    profile_picture ? profile_picture.image.url(style) : "#{style.to_s}/missing_poster.png"
  end

  def self.with_category(params)
    movie = Movie.includes(:ratings, :posters)
    if params == 'latest'
      movie = movie.latest_movies
    elsif params == 'featured'
      movie = movie.featured_movies
    elsif params == 'top_rated_movies'
      movie = movie.top_rated
    else
      movie = movie.all
    end
    movie.approved
  end

  def get_average_rating
    return 0 unless self.ratings.present?
    scores = self.ratings.pluck(:score)
    scores.inject{ |sum, el| sum + el }.to_f / scores.size
  end

  def get_ratings(user)
    user.ratings.for_movie(self).first || user.ratings.build(movie: self)
  end

  def added_to_favorites_by?(user_id)
    Favorite.exists?(user_id: user_id, movie_id: self.id)
  end

  def self.set_conditions(params)
    {
     conditions: {},
     with: {},
     order: 'release_date DESC',
     per_page: 12,
     page: params[:page],
     sql: {include: [:posters, :ratings]}
    }
  end

  def self.search_movies(params)
    conditions = set_conditions(params)

    conditions[:conditions][:genre] = params[:genre] if params[:genre].present?
    conditions[:conditions][:actors] = params[:actors] if params[:actors].present?
    conditions[:conditions][:description] = params[:description] if params[:description].present?
    conditions[:with][:release_date] = date_range(params[:start_date], params[:end_date])
    conditions[:with][:approved] = true

    search params[:search], conditions
  end

  def self.date_range(start_date, end_date)
    starting = start_date.to_s.to_time
    ending = end_date.to_s.to_time

    return starting..ending if starting.present? && ending.present?
    return starting..Date.today if starting.present? && starting < Date.today
    return Date.today..starting if starting.present?
    return Date.today..ending if ending.present? && ending > Date.today
    []
  end

  def details_hash
   {
     id: id,
     genre: genre,
     description: description,
     actors: actors.pluck(:id, :name, :biography, :gender, :created_at, :updated_at),
     reviews: reviews.pluck(:id, :user_id, :comment, :created_at, :updated_at, :report_count),
     ratings: ratings.pluck(:id, :score, :created_at, :updated_at, :user_id),
   }
 end

  def self.search_movie(params)
    conditions = {
      title: params[:title],
      genre: params[:genre],
      actors: params[:actors],
      release_date: params[:release_date]
    }

    Movie.search(conditions: conditions, with: DEFAULT_SEARCH_FILTER, order: DEFAULT_SEARCH_ORDER)
  end

  def self.get_movies(params)
    if params[:search]
      movies = Movie.search_movies(params)
    else
      movies = with_category(params[:filter])
    end
    movies = movies.page(params[:page])
  end

  def self.top_movies_of_category(category)
    movie = Movie.includes(:ratings, :posters)
    if category == 'latest'
      movie.latest_movies.approved.first(NUMBER_OF_MOVIES_IN_CATEGORY)
    elsif category == 'featured'
      movie.featured_movies.approved.first(NUMBER_OF_MOVIES_IN_CATEGORY)
    elsif category == 'top_rated_movies'
      movie.top_rated.approved.first(NUMBER_OF_MOVIES_IN_CATEGORY)
    else
      movie.all
    end
  end
end
