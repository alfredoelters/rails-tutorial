# Users
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# Microposts
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

# Tags
rails_rules = Tag.create!(name:"railsrules")
web_development = Tag.create!(name:"webdevelopment")
ruby = Tag.create!(name:"ruby")

Micropost.skip_callback(:save, :before, :extract_tags)

users.each do |user|
  30.times do
    all_tags_content =  "#railsRULES " + Faker::Lorem.sentence(1) + " #WEBdevelopment " + Faker::Lorem.sentence(1) + " #Ruby"
    user.microposts.create!(content: all_tags_content, tags:[rails_rules, ruby, web_development])
  end
  web_development_content = "#webDevelopment " + Faker::Lorem.sentence(3)
  user.microposts.create!(content: web_development_content, tags:[web_development])
  ruby_content = Faker::Lorem.sentence(1) + " #RUBY " + Faker::Lorem.sentence(1)
  user.microposts.create!(content: ruby_content, tags:[ruby])
  rails_rules_content = Faker::Lorem.sentence(3) + " #railsRULES "
  user.microposts.create!(content: rails_rules_content, tags:[rails_rules])
end


Micropost.set_callback(:save, :before, :extract_tags)
