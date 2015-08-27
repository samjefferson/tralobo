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