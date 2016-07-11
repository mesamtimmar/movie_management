class HomeController < ApplicationController

  def index
    @latest = Movie.latest_movies.first(5)
    @featured = Movie.featured_movies.first(5)
  end
end
