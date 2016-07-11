# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
actor_list = [
  ["Al Pacino", "male", "Best Actor of All time"],
  ["Robert di Noire", "male", "Best Actor of All time"],
  ["Marlon Brando", "male", "Best Actor of All time"],
  ["Denzal Washington", "male", "Best Actor of All time"]
]

actor_list.each do |name, gender, biography|
  Actor.create(name: name, gender: gender, biography: biography)
end
