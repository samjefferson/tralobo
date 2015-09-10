User.create!(username:  "test123",
             email: "test123@example.com",
             password:              "samuel1",
             password_confirmation: "samuel1",
             admin: true)

99.times do |n|
  name  = Faker::Name.last_name+rand(10000).to_s
  email = "example-#{n+1}@example.com"
  password = "password1"
  User.create!(username:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

  users = User.order(:created_at).take(6)
50.times do
	title = Faker::Lorem.word
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.logs.create!(title: title, content: content, location_id: 1) }
end

Location.create(continent: 0, state: 1, city: 'Gotham', coordinate: '00.00,00.00')

user = User.first
logs = Log.where(user_id: user.id).order(:created_at).take(3)

5.times do
  content = Faker::Lorem.sentence(4)
  logs.each { |log| log.comments.create!(content: content, user_id: 1) }
end
