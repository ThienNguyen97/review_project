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
