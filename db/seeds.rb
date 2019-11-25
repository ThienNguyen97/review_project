Role.create(name: 'moderator')
Role.create(name: 'admin')

user1 = User.create(email: 'admin@test.com',
          password: '123456',
          password_confirmation: '123456',
          name: 'Admin')
user1.add_role(:admin)
user2 = User.create(email: 'user@test.com',
          password: '123456',
          password_confirmation: '123456',
          name: 'Adv Manage')
user2.add_role(:moderator)

10.times do |n|
  name  = Faker::Name.name
  email = "test#{n+1}@test.com"
  password = "password"
  User.create! name:  name,
    email: email,
    gender: Faker::Gender.binary_type,
    birthday: Faker::Date.between(from: 50.years.ago,to: 10.years.ago),
    password: password,
    password_confirmation: password
end

10.times do
  City.create(
    name: Faker::Address.city
    )
end
cities = City.order('name ASC').take(3)
cities.each do |city|
  5.times do
    Place.create! name: Faker::Restaurant.name,
      content: Faker::Restaurant.description,
      address: Faker::Address.street_address,
      city_id: city.id
  end
end

places = Place.order(:created_at)
places.each do |place|
  (1..8).to_a.shuffle.take(3).each do |i|
    PlaceImage.create! link: "https://res.cloudinary.com/hedspi/image/upload/v1564448966/travel-discovery/hotels/#{i}.jpg", place_id: place.id
  end
end

users = User.order(:id)
users.each do |user|
  7.times do
    Post.create! title: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4),
     content: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4),
     status: Faker::Number.between(from: 1,to: 20),
     user_id: user.id,
     place_id: Faker::Number.between(from: 1,to: 5)
  end
end

#Following/Followers
users = User.all
user  = users.first
following = users[2..5]
followers = users[3..9]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

posts = Post.all
posts.each do |post|
  (1..8).to_a.shuffle.take(3).each do |i|
        PostImage.create! remote_link_url: "https://res.cloudinary.com/hedspi/image/upload/v1564448966/travel-discovery/hotels/#{i}.jpg", post_id: post.id
  end

  (1..10).to_a.shuffle.take(2).each do |i|
    PostImage.create! remote_link_url: "https://res.cloudinary.com/hedspi/image/upload/v1564448966/travel-discovery/play_places/#{i}.jpg", post_id: post.id
  end
end

# users = User.order(:created_at).take(6)
# posts = Post.order(:created_at).take(10)
# posts.each do |post|
#   users.each do |user|
#     Comment.create! content: Faker::Lorem.sentence,
#       user_id: user.id,
#       post_id: post.id
#   end
# end

ReactionType.create(
  description: "like"
)

reaction_type_id = ReactionType.first.id
users = User.order(:created_at).take(9)
posts = Post.order(:created_at).take(12)
posts.each do |post|
  users.each do |user|
    Reaction.create! reaction_type_id: reaction_type_id,
      user_id: user.id,
      post_id: post.id
  end
end
