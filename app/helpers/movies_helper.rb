module MoviesHelper
  def formated_date(date)
    date.strftime('%d/%m/%Y') if date.present?
  end

  def poster_present?(poster)
    poster.object.image.url(:thumb) == 'thumb/missing.png'
  end

  def favorite_button_id(movie, user)
    ['favorite', movie.id, user.id].join
  end

  def set_to_rating_id(rating)
    rating.id if user_signed_in?
  end
end
