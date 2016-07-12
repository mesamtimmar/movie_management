class ReviewsController < ApplicationController
  before_action :set_review, only: [:update, :destroy, :edit]
  before_action :set_movie

  def create
    @review = @movie.reviews.new(review_params)
    @review.user_id = current_user.id

    respond_to do |format|
      if @review.save
        format.html { redirect_to @movie, notice: 'Review was successfully created.' }
      else
        format.html { redirect_to @movie, alert: 'Review could not be created.' }
      end
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @movie, notice: 'Review was successfully updated.' }
      else
        format.html { redirect_to @movie, alert: 'Review could not be updated.' }
      end
      format.js
    end
  end

  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to @movie, notice: 'Review was successfully destroyed.' }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:comment)
    end

    def set_movie
      @movie = Movie.find(params[:movie_id])
    end
end
