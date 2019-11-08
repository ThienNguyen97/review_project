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

posts = Post.all
posts.each do |post|
  (1..8).to_a.shuffle.take(3).each do |i|
        PostImage.create! link: "https://res.cloudinary.com/hedspi/image/upload/v1564448966/travel-discovery/hotels/#{i}.jpg", post_id: post.id
  end

  (1..10).to_a.shuffle.take(2).each do |i|
    PostImage.create! link: "https://res.cloudinary.com/hedspi/image/upload/v1564448966/travel-discovery/play_places/#{i}.jpg", post_id: post.id
  end
end
