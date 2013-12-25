# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#data -
#  format - yyyy-mm-dd, yyyy/mm/dd.....
#  week_start - 0-6
#  start_date - can't pick the date before the start_date.
#  end_date - can't pick the date after the end_date.
#  view_mode - 0..month，1..year，2..10 years
#  min_view_mode - not be tested....
#  language - default pt-BR, see bootstrap-datetimepicker API
#  mask_input - true, false disables the text input mask
#  pick_date - true, false disables the date picker
#  pick_time - true, false disables de time picker
#  pick_12_hour_format - false, true enables the 12-hour format time picker
#  pick_seconds - true

product = Product.create!(name: "个人取名", price: 100)
product.product_attributes.create!(name: "出生日期及时间", attr_type: "input", params: "{label: '出生日期及时间', as: :dt_picker, input_html: {data:{format:'yyyy-MM-dd hh:mm',language:'zh-CN',pick_seconds:false} } }", requirement: 'return value.blank?', error_messages: "{true=>'生日不能为空'}")
product.product_attributes.create!(name: "性别", attr_type: "input", params: "{label: '性别', priority: [ '男' ], collection: [ '男', '女' ]}")
product.product_attributes.create!(name: "父亲姓名", attr_type: "input", params: "{label: '父亲姓名'}")
product.product_attributes.create!(name: "母亲姓名", attr_type: "input", params: "{label: '母亲姓名'}")
product.product_attributes.create!(name: "父亲出生日期及时间", attr_type: "input", params: "{label: '父亲出生日期及时间', as: :dt_picker, input_html: {data:{format:'yyyy-MM-dd hh:mm',language:'zh-CN',pick_seconds:false} } }", requirement: 'return value.blank?', error_messages: "{true=>'父亲生日不能为空'}")
product.product_attributes.create!(name: "母亲出生日期及时间", attr_type: "input", params: "{label: '母亲出生日期及时间', as: :dt_picker, input_html: {data:{format:'yyyy-MM-dd hh:mm',language:'zh-CN',pick_seconds:false} } }")
product.product_attributes.create!(name: "姓氏要求", attr_type: "input", params: "{label: '姓氏要求', priority: ['随父姓'], collection: ['随父姓', '随母姓', '其他（请在特殊要求中注明）']}")
product.product_attributes.create!(name: "姓名字数", attr_type: "input", params: "{label: '姓名字数', priority: ['3'], collection: ['2', '3', '4', '其他（请在特殊要求中注明）']}")
product.product_attributes.create!(name: "特殊要求", attr_type: "input", params: "{label: '特殊要求', as: :text, hint: '如:某一位必须出现/不能出现某字'}")
product.product_attributes.create!(name: "手机号码", attr_type: "input", params: "{label: '手机号码'}")
product.product_attributes.create!(name: "微信帐号", attr_type: "input", params: "{label: '微信账号'}")

product = Product.create!(name: "公司取名", price: 1000)
product.product_attributes.create!(name: "公司名前缀", attr_type: "input", params: "{label: '公司名前缀'}")
product.product_attributes.create!(name: "公司名后缀", attr_type: "input", params: "{label: '公司名后缀'}")
product.product_attributes.create!(name: "公司名长度（不含前后缀）", attr_type: "input", params: "{label: '公司名长度', hint: '不含给定的前后缀'}")
product.product_attributes.create!(name: "公司所属行业", attr_type: "input", params: "{label: '公司所属行业', collection: ['东印度公司', '怪物电力公司', '想象力有限公司']}")
product.product_attributes.create!(name: "公司创建日期", attr_type: "input", params: "{label: '公司创建日期', as: :dt_picker, input_html: {data:{format:'yyyy-MM-dd',language:'zh-CN',pick_time:false } } }")
product.product_attributes.create!(name: "负责人出生日期及时间", attr_type: "input", params: "{label: '负责人出生日期及时间', as: :dt_picker, input_html: {data:{format:'yyyy-MM-dd hh:mm',language:'zh-CN', pick_seconds:false} }, hint: '如经理、法人代表、CEO等'}")
product.product_attributes.create!(name: "特殊要求", attr_type: "input", params: "{label: '特殊要求', as: :text}")
product.product_attributes.create!(name: "手机帐号", attr_type: "input", params: "{label: '手机号码'}")
product.product_attributes.create!(name: "微信帐号", attr_type: "input", params: "{label: '微信账号'}")

product = Product.create!(name: "八字断命", price: 800)
product.product_attributes.create!(name: "出生日期及时间", attr_type: "input", params: "{label: '出生日期及时间', as: :dt_picker, input_html: {data:{format:'yyyy-MM-dd hh:mm',language:'zh-CN', pick_seconds: false} } }", requirement: "if value.blank? then errors.add(:value,'must input birthdate') and puts true else puts false end")
product.product_attributes.create!(name: "出生省份", attr_type: "input", params: "{label: '出生省份', collection: ['海外地区或特殊地区（请在特殊要求中注明）', '北京市', '天津市', '河北省', '山西省', '内蒙古自治区', '辽宁省', '吉林省', '黑龙江省', '海市', '江苏省', '浙江省', '安徽省', '福建省', '江西省', '山东省', '河南省', '湖北省', '湖南省', '广东省', '广西壮族自治区', '海南省', '重庆市', '四川省', '贵州省', '云南省', '西藏自治区', '陕西省', '甘肃省 ', '青海省', '宁夏回族自治区', '新疆维吾尔自治区', '香港特别行政区', '澳门特别行政区', '台湾省'  ]}")
product.product_attributes.create!(name: "出生地点", attr_type: "input", params: "{label: '出生地点', hint: '如市、县、乡、村等'}")
product.product_attributes.create!(name: "算命方向", attr_type: "input", params: "{label: '算命方向', as: :check_boxes, collection: ['事业', '爱情、婚姻']}", multiple: true)
product.product_attributes.create!(name: "特殊要求", attr_type: "input", params: "{label: '特殊要求', as: :text}")
product.product_attributes.create!(name: "手机帐号", attr_type: "input", params: "{label: '手机号码'}")
product.product_attributes.create!(name: "微信帐号", attr_type: "input", params: "{label: '微信账号'}")




#product.product_attributes.create!(name: "Birthday", attr_type: "dt_picker", params: "{label: '生日'}")
#product.product_attributes.create!(name: "Father's name", attr_type: "input")
#product.product_attributes.create!(name: "Mother's name", attr_type: "input")

#product = Product.create!(name: "Company", price: 1000)
#product.product_attributes.create!(name: "Birthday", attr_type: "input")
#product.product_attributes.create!(name: "Business", attr_type: "input")