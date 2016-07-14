class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie
  has_many :reported_reviews, dependent: :destroy
  validates :comment, presence: true, length: { maximum: 2000, minimum: 5 }
  validates :user_id, presence: true
  validates :movie_id, presence: true

  def show_user_dp(style = :original)
    self.user.show_profile_picture(style)
  end

  def owner?(user_id)
    self.user_id == user_id
  end

  def reported_by?(user_id)
    self.reported_reviews.where(user_id: user_id).present?
  end
end
