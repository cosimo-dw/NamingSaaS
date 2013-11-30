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

  task seed: :environment do
    product = Product.create!(name: "Personal", price: 100)
    product.product_attributes.create!(name: "出生日期及时间", attr_type: "input", params: "{label: '出生日期及时间', as: :dt_picker}", requirement: 'return value.blank?', error_messages: "{true=>'不能为空'}")
    product.product_attributes.create!(name: "性别", attr_type: "input", params: "{label: '性别', priority: [ '男' ], collection: [ '男', '女' ]}")
    product.product_attributes.create!(name: "父亲姓名", attr_type: "input", params: "{label: '父亲姓名'}")
    product.product_attributes.create!(name: "母亲姓名", attr_type: "input", params: "{label: '母亲姓名'}")
    product.product_attributes.create!(name: "父亲出生日期及时间", attr_type: "input", params: "{label: '父亲出生日期及时间', as: :dt_picker}")
    product.product_attributes.create!(name: "母亲出生日期及时间", attr_type: "input", params: "{label: '母亲出生日期及时间', as: :dt_picker}")
    product.product_attributes.create!(name: "姓氏要求", attr_type: "input", params: "{label: '姓氏要求', priority: ['随父姓'], collection: ['随父姓', '随母姓', '其他（请在特殊要求中注明）']}")
    product.product_attributes.create!(name: "姓名字数", attr_type: "input", params: "{label: '姓名字数', priority: ['3'], collection: ['2', '3', '4', '其他（请在特殊要求中注明）']}")
    product.product_attributes.create!(name: "特殊要求", attr_type: "input", params: "{label: '特殊要求', as: :text, hint: '如:某一位必须出现/不能出现某字'}")
    product.product_attributes.create!(name: "手机号码", attr_type: "input", params: "{label: '手机号码'}")
    product.product_attributes.create!(name: "微信帐号", attr_type: "input", params: "{label: '微信账号'}")

    product = Product.create!(name: "Company", price: 1000)
    product.product_attributes.create!(name: "公司名前缀", attr_type: "input", params: "{label: '公司名前缀'}")
    product.product_attributes.create!(name: "公司名后缀", attr_type: "input", params: "{label: '公司名后缀'}")
    product.product_attributes.create!(name: "公司名长度（不含前后缀）", attr_type: "input", params: "{label: '公司名长度', hint: '不含给定的前后缀'}")
    product.product_attributes.create!(name: "公司所属行业", attr_type: "input", params: "{label: '公司所属行业', collection: ['东印度公司', '怪物电力公司', '想象力有限公司']}")
    product.product_attributes.create!(name: "公司创建日期", attr_type: "input", params: "{label: '公司创建日期', as: :dt_picker}")
    product.product_attributes.create!(name: "负责人出生日期及时间", attr_type: "input", params: "{label: '负责人出生日期及时间', as: :dt_picker, hint: '如经理、法人代表、CEO等'}")
    product.product_attributes.create!(name: "特殊要求", attr_type: "input", params: "{label: '特殊要求', as: :text}")
    product.product_attributes.create!(name: "手机帐号", attr_type: "input", params: "{label: '手机号码'}")
    product.product_attributes.create!(name: "微信帐号", attr_type: "input", params: "{label: '微信账号'}")




    #product.product_attributes.create!(name: "Birthday", attr_type: "dt_picker", params: "{label: '生日'}")
    #product.product_attributes.create!(name: "Father's name", attr_type: "input")
    #product.product_attributes.create!(name: "Mother's name", attr_type: "input")

    #product = Product.create!(name: "Company", price: 1000)
    #product.product_attributes.create!(name: "Birthday", attr_type: "input")
    #product.product_attributes.create!(name: "Business", attr_type: "input")


  end
end