# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do |n|

  pic_user_id = 1 + n
  name = Faker::Book.author
  email = Faker::Internet.email
  password = "password"
  avatar = Faker::Avatar.image
  comment = Faker::StarWars.quote
  uid = Faker::Crypto.md5
  username = Faker::Internet.user_name
  image_path = File.join(Rails.root, "db/fixture/no_image.png")
  User.create!(name: name,
               uid: uid,
               username: username,
               email: email,
               password: password,
               password_confirmation: password,
               )
  Picture.create!(comment: comment,
                  avatar: File.new(image_path),
                  user_id: pic_user_id
  )
end
