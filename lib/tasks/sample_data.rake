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
    product.product_attributes.create!(name: "birthday_kid", attr_type: "input", params: "{label: '出生日期及时间', as: :dt_picker}")
    product.product_attributes.create!(name: "sex", attr_type: "input", params: "{label: '性别', priority: [ 'Male' ], collection: [ 'Male', 'Female' ]}")
    product.product_attributes.create!(name: "father_name", attr_type: "input", params: "{label: '父亲姓名'}")
    product.product_attributes.create!(name: "mother_name", attr_type: "input", params: "{label: '母亲姓名'}")
    product.product_attributes.create!(name: "father_birthday", attr_type: "input", params: "{label: '父亲出生日期及时间', as: :dt_picker}")
    product.product_attributes.create!(name: "mother_birthday", attr_type: "input", params: "{label: '母亲出生日期及时间', as: :dt_picker}")
    product.product_attributes.create!(name: "expected_last_name", attr_type: "input", params: "{label: '姓氏要求', priority: ['随父姓'], collection: ['随父姓', '随母姓', '其他（请在特殊要求中注明）']}")
    product.product_attributes.create!(name: "length_kid", attr_type: "input", params: "{label: '姓名字数', priority: ['3'], collection: []}")
    product.product_attributes.create!(name: "special_request_kid", attr_type: "input", params: "{label: '特殊要求', as: :text, hint: '如:某一位必须出现/不能出现某字'}")
    product.product_attributes.create!(name: "mobile_phone_number_kid", attr_type: "input", params: "{label: '手机号码'}")
    product.product_attributes.create!(name: "wechat_kid", attr_type: "input", params: "{label: '微信账号'}")

    product = Product.create!(name: "Company", price: 1000)
    product.product_attributes.create!(name: "prefix", attr_type: "input", params: "{label: '公司名前缀'}")
    product.product_attributes.create!(name: "postfix", attr_type: "input", params: "{label: '公司名后缀'}")
    product.product_attributes.create!(name: "length_com", attr_type: "input", params: "{label: '公司名长度', hint: '不含给定的前后缀'}")
    product.product_attributes.create!(name: "business", attr_type: "input", params: "{label: '公司所属行业', collection: ['东印度公司', '怪物电力公司', '想象力有限公司', '算命就是骗人的公司']}")
    product.product_attributes.create!(name: "birthday_com", attr_type: "input", params: "{label: '公司创建日期', as: :dt_picker}")
    product.product_attributes.create!(name: "birthday_cli", attr_type: "input", params: "{label: '负责人出生日期及时间', as: :dt_picker hint: '如经理、法人代表、CEO等'}")
    product.product_attributes.create!(name: "special_request_com", attr_type: "input", params: "{label: '特殊要求', as: :text}")
    product.product_attributes.create!(name: "mobile_phone_number_com", attr_type: "input", params: "{label: '手机号码'}")
    product.product_attributes.create!(name: "wechat_com", attr_type: "input", params: "{label: '微信账号'}")




    #product.product_attributes.create!(name: "Birthday", attr_type: "dt_picker", params: "{label: '生日'}")
    #product.product_attributes.create!(name: "Father's name", attr_type: "input")
    #product.product_attributes.create!(name: "Mother's name", attr_type: "input")

    #product = Product.create!(name: "Company", price: 1000)
    #product.product_attributes.create!(name: "Birthday", attr_type: "input")
    #product.product_attributes.create!(name: "Business", attr_type: "input")


  end
end