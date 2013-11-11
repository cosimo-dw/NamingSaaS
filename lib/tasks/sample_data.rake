namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      name  = Faker::Name.first_name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    #users = User.all(limit: 6)
    #50.times do
    #  #content = Faker::Lorem.sentence(5)
    #  users.each { |user| user.orders.create!(product_id: 1, price: 3.14) }
    #end

    product = Product.create!(name: "Personal", price: 100)
    product.product_attributes.create!(name: "Birthday", attr_type: "dt_picker", params: "{label: '生日'}")
    product.product_attributes.create!(name: "Father's name", attr_type: "input")
    product.product_attributes.create!(name: "Mother's name", attr_type: "input")

    product = Product.create!(name: "Company", price: 1000)
    product.product_attributes.create!(name: "Birthday", attr_type: "input")
    product.product_attributes.create!(name: "Business", attr_type: "input")


  end
end