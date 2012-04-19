FactoryGirl.define do
  factory :address do
    cell_phone_number { PhoneNumber.random_phone_number }
    country { |c| "Country #{c}"}
    label { |l| "Label #{l}"}
    street { |s| "Street #{s}"}
    town { |t| "Town #{t}"}
  end

  factory :client do
    sequence(:name) { |n| "Client #{n}" }
    addresses { |a| [a.association(:address)] }
  end

  factory :invoice do
    sequence(:invoice_number) { |n| n }

    description "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    state { Invoice.random_state }
    uuid { SecureRandom.uuid }

    association :organisation
    from_address_id { |o| o.organisation.id }

    association :client
    to_address_id { |c| c.client.id }
  end

  factory :organisation do
    sequence(:name) { |n| "Organisation #{n}" }
    sequence(:subdomain) { |n| "subdomain#{n}" }
    addresses { |a| [a.association(:address)] }
  end

  factory :receipt do
    sequence(:receipt_number) { |n| n }

    amount { (rand 1000000000)/100.0 }
    currency { Currency.random_currency_code }
    payment_method { Payment.random_payment_method }
    received_at { Time.now }
    uuid { SecureRandom.uuid }

    association :organisation
    to_address_id { |o| o.organisation.id }

    association :client
    from_address_id { |c| c.client.id }
  end
  
  factory :user do
    sequence(:email) { |n| "grace#{n}@example.com" }
    sequence(:username) { |n| "grace#{n}" }

    cell_phone_number { PhoneNumber.random_phone_number }
    language { Language.random_language }
    name "Grace Nyambe"
    password AppConfig.test_user_password
    time_zone "Harare"
  end
end
