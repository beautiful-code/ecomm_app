FactoryGirl.define do
  factory :product do
    name            "Nexus"
    units           1
    manufacturer    "LG"
    cost            22400
    description     "powered by Google"
  end

  factory :user do
    name    "Test User"
    email   "test@example.com"
    address "ecomm_app spec factories"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :order do
    user
  end

  factory :order_item do
    order
    product
  end

  factory :review do
    user
    product
    content " Test content "
    title "sample title"
  end

  factory :rating do
    user
    product
    rating_value 4
  end
end
