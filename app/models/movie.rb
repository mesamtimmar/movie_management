class Movie < ActiveRecord::Base
  def show_desc
    self.description.to_s.html_safe
  end

  def show_trailer
    self.trailer.to_s.html_safe
  end
end
