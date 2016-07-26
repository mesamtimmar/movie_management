class HomeController < ApplicationController

  def index
    @latest = Movie.top_movies_of_category('latest')
    @featured = Movie.top_movies_of_category('featured')
    @top_rated_movies = Movie.top_movies_of_category('top_rated_movies')
  end
end
