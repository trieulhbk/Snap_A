namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_categories
    make_boxes
    make_photos
    make_relationships
  end
end

def make_users
   admin = User.create!(name:"Example User",
    email:    "example@railstutorial.org",
    password: "foobar",
    password_confirmation: "foobar")
   admin.toggle!(:admin)
  10.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name:     name,
     email:    email,
     password: password,
     password_confirmation: password)
  end
end

def make_categories
  20.times do |n|
    name = Faker::Address.city
    Category.create!(name: name)
  end
end

def make_boxes
  users = User.all(limit: 5)
  5.times do
    name = Faker::Company.name
    category = rand(20) + 1
    users.each { |user| user.boxes.create!(name: name, category_id: category)}
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..10]
  followers      = users[3..8]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

def make_user_box_rel

  boxes = Box.all[1..4]
  following_box_user = User.find(3)

  boxes.each do | box |
    following_box_user.follow_box!(box)
  end
end

def make_photos
  users = User.all(limit: 5)
  size=[
    { x: 300, y: 400 },
    { x: 500, y: 500 },
    { x: 640, y: 480 },
    { x: 300, y: 600 }
  ]
  5.times do
    users.each do |user|
      user.boxes.each do |b|
        10.times do
          name = Faker::PhoneNumber.phone_number
          description = Faker::Internet.domain_name
          temp = size[rand(3)]
          source = "http://placehold.it/#{temp[:x]}x#{temp[:y]}"
          b.photos.create(name: name, description: description, source: source, image_remote_url: source)
        end
      end
    end
  end
end
