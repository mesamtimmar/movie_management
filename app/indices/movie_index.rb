ThinkingSphinx::Index.define :movie, delta: true, with: :active_record do
  indexes title, sortable: true
  indexes description
  indexes actors.name , as: :actors
  indexes genre
  has release_date
  has approved
  has featured
end
