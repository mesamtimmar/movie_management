class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  def show_user_dp(style = :original)
    self.user.show_profile_picture(style)
  end
end
