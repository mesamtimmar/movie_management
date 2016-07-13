class ReportedReview < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  after_create :increment_report_count

  def increment_report_count
    self.review.update(report_count: self.review.report_count + 1)
  end
end
