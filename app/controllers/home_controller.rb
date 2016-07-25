class HomeController < ApplicationController

  def index
    @latest = Movie.latest_movies.approved.first(4)
    @featured = Movie.featured_movies.approved.first(4)
    @top_rated_movies = Movie.top_rated.approved.first(4)
  end
end
