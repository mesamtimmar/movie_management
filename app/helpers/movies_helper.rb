module MoviesHelper
  def formated_date(date)
    date.strftime('%d/%m/%Y') if date.present?
  end

  def poster_present?(poster)
    poster.object.image.url(:thumb) == 'thumb/missing.png'
  end
end
