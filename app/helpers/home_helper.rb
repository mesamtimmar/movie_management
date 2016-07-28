module HomeHelper
  def movies_present?(top, latest, featured)
    return (top.blank? && latest.blank? && featured.blank?)
  end
end
