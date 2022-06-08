# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

Review.destroy_all
Book.destroy_all
User.destroy_all

user = User.new(username: "Bhawana", email: "x@gmail", password: "123456")
user.save!

description = ["Entails the facinating world of science fiction",
  "Very emotional life journey which shows the struggle at different stages",
  "Latest trends how the market booming economies are impacted",
  "Managing the business along with the booming technology",
  "World of female fantasies and the criminalites surrounding it"
]

images = [

]

puts 'Creating 10 fake books...'
10.times do
  book = Book.create!(
    title: Faker::Book.title,
    author: Faker::Book.author,
    summary: description.sample,
    publishing_year: rand(1990..2022),
    price: rand(10..30),
    user: user
  )
end

Book.all.each do |book|
  rand(4).times do
    Review.create!(
      comment: Faker::Lorem.paragraph(sentence_count: 2),
      rating: rand(5),
      book: book,
      user: User.all.sample
    )
  end
end

puts 'Finished!'
