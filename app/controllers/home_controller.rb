class HomeController < ApplicationController

  def index
    @latest = Movie.latest_movies.first(4)
    @featured = Movie.featured_movies.first(4)
    @top_rated_movies = Movie.top_rated.first(4)
  end
end
