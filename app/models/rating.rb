class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  scope :for_movie, -> (movie) { where(movie_id: movie.id) }
end
