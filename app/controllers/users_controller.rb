class UsersController < ApplicationController
  def show
    @user = current_user
    @favorite_movies = User.get_favorite_movies(@user, params)
  end
end
