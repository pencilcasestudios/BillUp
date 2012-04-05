FactoryGirl.define do
  factory :address do
    sequence(:cell_phone_number) { PhoneNumber.random }
    sequence(:country) { |n| "Country #{n}" }
    sequence(:email) { |n| "email#{n}@example.com" }
    sequence(:fax_number) { PhoneNumber.random }
    sequence(:label) { |n| "Label #{n}" }
    sequence(:land_line_number) { PhoneNumber.random }
    sequence(:postal_code) { |n| "Postal Code #{n}" }
    sequence(:province) { |n| "Province #{n}" }
    sequence(:street) { |n| "Street #{n}" }
    sequence(:town) { |n| "Town #{n}" }
    sequence(:website) { |n| "http://website#{n}.example.com" }
  end
  
  factory :client do
    sequence(:name) { |n| "Client #{n}" }
    sequence(:organisation_id) { |n| "#{n}" }

    association :organisation
    addresses { |a| [a.association(:address)] }
  end
  
  factory :invoice do
    sequence(:description) { |n| "Description #{n}" }
    sequence(:invoice_number) { |n| n }

    association :client
    association :organisation
    from_address_id { |c| c.client.id }
    to_address_id { |o| o.organisation.id }

    sequence(:uuid) { SecureRandom.uuid }
    sequence(:state) { InvoiceState::STATES[InvoiceState::STATES.to_a[rand InvoiceState::STATES.size].first] }
  end

  factory :organisation do
    sequence(:name) { |n| "Organisation #{n}" }
    sequence(:subdomain) { |n| "subdomain#{n}" }

    addresses { |a| [a.association(:address)] }
  end

  factory :receipt do
    sequence(:amount) { |n| n }
    sequence(:description) { |n| "Description #{n}" }
    sequence(:receipt_number) { |n| n }

    association :client
    association :organisation
    from_address_id { |o| o.organisation.id }
    to_address_id { |c| c.client.id }

    sequence(:currency) { Currency::CODES[Currency::CODES.to_a[rand Currency::CODES.size].first] }
    sequence(:payment_method) { Payment::TYPES[Payment::TYPES.to_a[rand Payment::TYPES.size].first] }
    sequence(:received_at) { Time.now }
    sequence(:uuid) { SecureRandom.uuid }
  end
  
  factory :user do
    sequence(:email) { |n| "grace#{n}@example.com" }
    sequence(:username) { |n| "grace#{n}" }
    sequence(:cell_phone_number) { PhoneNumber.random }

    name "Grace Nyambe"
    language "eng"
    password AppConfig.test_user_password
    time_zone "Harare"
  end  
end
