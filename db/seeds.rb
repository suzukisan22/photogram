# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do |n|
  name = Faker::Book.author
  email = Faker::Internet.email
  password = "password"
  avatar = Faker::Avatar.image
  comment = Faker::StarWars.quote
  uid = Faker::Crypto.md5
  User.create!(name: name,
               uid: uid,
               email: email,
               password: password,
               password_confirmation: password,
               avatar: avatar
               )
  Picture.create!(avatar: "enu-thumbnail2.jpg",
                  comment: comment
  )
end
