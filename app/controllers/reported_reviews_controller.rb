class ReportedReviewsController < ApplicationController
  before_action :set_review

  def create
    @report = @review.reported_reviews.new
    @report.user_id = current_user.id
    @report.save
  end

  def set_review
    @review = Review.find(params[:review_id])
  end
end
