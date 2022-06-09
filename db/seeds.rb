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

description = [
  "Entails the facinating life of normal people",
  "Very emotional life journey which shows the struggle at different stages",
  "Managing the business along with the booming technology",
  "Cultural look out in the life, design, style",
  "World of female fantasies and the criminalites surrounding it",
  "Story revovles around he says and she says",
  "Based on the emotional entanglements of mind and life",
  "Latest trends how the investments and the markets are impacted as per the booming or the slow growth-rate economies "
]

images = [
  "happy.jpg",
  "book_full_of_hope.jpg",
  "how_innovation_works.jpg",
  "kinfolk.jpg",
  "identity_theft.jpg",
  "milk_honey.jpg",
  "how_to_stop_worrying_start_living.jpg",
  "thinking_fast_and_slow.jpg"
]

puts 'Creating 10 fake books...'

happy = Book.create!(
  title: "Happy",
  author: "Alex Lemon",
  summary: description.sample,
  image: images[0],
  publishing_year: rand(1990..2022),
  price: rand(10..30),
  user: user
)

How_innovation_works = Book.create!(
  title: "How innovation works",
  author: "Matt Ridley",
  summary: description.sample,
  image: images[2],
  publishing_year: rand(1990..2022),
  price: rand(10..30),
  user: user
)

How_to_stop_worrying_start_living = Book.create!(
  title: "How to stop worrying start living",
  author: "Dale Carnigie",
  summary: description.sample,
  image: images[6],
  publishing_year: rand(1990..2022),
  price: rand(10..30),
  user: user
)

 Identity_theft = Book.create!(
  title: "Identity theft",
  author: "Melisa Kruger",
  summary: description.sample,
  image: images[4],
  publishing_year: rand(1990..2022),
  price: rand(10..30),
  user: user
)

Kinfolk = Book.create!(
  title: "Kinfolk",
  author: "Williams",
  summary: description.sample,
  image: images[3],
  publishing_year: rand(1990..2022),
  price: rand(10..30),
  user: user
)

 Milk_and_Honey = Book.create!(
  title: "Milk and Honey",
  author: "Raupi Kaur",
  summary: description.sample,
  image: images[5],
  publishing_year: rand(1990..2022),
  price: rand(10..30),
  user: user
)

 Thinking_fast_and_slow = Book.create!(
  title: "Thinking fast and slow",
  author: "Daniel Kahneman",
  summary: description.sample,
  image: images[7],
  publishing_year: rand(1990..2022),
  price: rand(10..30),
  user: user
)

 Book_full_of_hope = Book.create!(
  title: "Book full of hope",
  author: "Xyz",
  summary: description.sample,
  image: images[1],
  publishing_year: rand(1990..2022),
  price: rand(10..30),
  user: user
)

review_description = [
  "Great read",
  "Beautifuly described, good book",
  "Must read",
  "Nice story-line",
  "Awesome"
]
Book.all.each do |book|
  rand(4).times do
    Review.create!(
      comment: review_description.sample,
      rating: rand(5),
      book: book,
      user: User.all.sample
    )
  end
end

puts 'Finished!'
