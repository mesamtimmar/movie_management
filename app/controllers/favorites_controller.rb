class FavoritesController < ApplicationController
  before_action :set_movie, only: [:create]

  def create
    @favorite = current_user.favorites.new
    @favorite.movie_id = params[:movie_id]
    @favorite.save
  end

  def destroy
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
