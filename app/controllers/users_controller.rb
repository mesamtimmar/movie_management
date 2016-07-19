class UsersController < ApplicationController
  def show
    @user = current_user
    @favorite_movies = @user.favorite_movies.page(params[:page])
  end
end
