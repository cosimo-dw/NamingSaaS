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

  factory :character do
    sequence(:code)  { |n| '4E00'.to_i(16)+n }
    sequence(:structure) { |n| ['2FF0'.to_i(16) + (n % 12)].pack('U*') }
    sequence(:zongbihua) { |n| n }
  end

  factory :product do
    name "个人取名"
    sequence(:price)  { |n| 10**n }
  end

  factory :product_attribute do
    sequence(:name) { |n| "name#{n+1}" }
    attr_type "input"
    params "{label: 'Name'}"
    product
    factory :non_blank_attribute do
      params "{label: '*Name'}"
      requirement "if value.blank? then errors.add(:name,'must input birthdate') and return true else return false end"
    end
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
