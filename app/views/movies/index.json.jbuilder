json.array!(@movies) do |movie|
  json.extract! movie, :id, :title, :trailer, :description, :approved, :featured
  json.url movie_url(movie, format: :json)
end
