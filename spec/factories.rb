FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :product do
    sequence(:name)  { |n| "Product #{n}" }
    sequence(:price)  { |n| 10**n }
  end

  factory :product_attribute do
    name "Birth"
    attr_type "input"
    product
  end

  factory :order do
    product
    user
  end

  factory :message do
    is_user true
    content "I love you~~~"
    order
  end
end
