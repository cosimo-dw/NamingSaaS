namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "example@tsinghuax.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      name  = Faker::Name.first_name
      email = "user-#{n+1}@tsinghuax.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)

    end
    User.create!(name: "Example Admin",
                 email: "admin@tsinghuax.org",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)

    #Order.create!(user_id: 1, product_id: 1)
    #Order.create!(user_id: 1, product_id: 2)

    #orders = Order.all
    #40.times do
      #content = Faker::Lorem.sentence(5)
      #orders.each { |o| o.messages.create!(content: content, is_user: true, ) }
    #end

    #users = User.all(limit: 6)
    #50.times do
    #  #content = Faker::Lorem.sentence(5)
    #  users.each { |user| user.orders.create!(product_id: 1, price: 3.14) }
    #end
  end

end