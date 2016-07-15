module MoviesHelper
  def formated_date(date)
    date.strftime('%d/%m/%Y') if date.present?
  end
end
