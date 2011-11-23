Factory.define :user do |f|
  f.sequence(:email) { |n| "grace#{n}@example.com" }
  f.sequence(:username) { |n| "grace#{n}" }
  f.sequence(:cell_phone_number) { PhoneNumber.random }

  f.name "Grace Nyambe"
  f.language "eng"
  f.password AppConfig.test_user_password
  f.time_zone "Harare"
end




Factory.define :address do |f|
  f.sequence(:cell_phone_number) { PhoneNumber.random }
  f.sequence(:country) { |n| "Country #{n}" }
  f.sequence(:email) { |n| "email#{n}@example.com" }
  f.sequence(:fax_number) { PhoneNumber.random }
  f.sequence(:label) { |n| "Label #{n}" }
  f.sequence(:land_line_number) { PhoneNumber.random }
  f.sequence(:postal_code) { |n| "Postal Code #{n}" }
  f.sequence(:province) { |n| "Province #{n}" }
  f.sequence(:street) { |n| "Street #{n}" }
  f.sequence(:town) { |n| "Town #{n}" }
  f.sequence(:website) { |n| "http://website#{n}.example.com" }
end





Factory.define :organisation do |f|
  f.sequence(:name) { |n| "Organisation #{n}" }
  f.sequence(:subdomain) { |n| "subdomain#{n}" }

  f.addresses { |a| [a.association(:address)] }
end




Factory.define :client do |f|
  f.sequence(:name) { |n| "Client #{n}" }
  f.sequence(:organisation_id) { |n| "#{n}" }

  f.association :organisation
  f.addresses { |a| [a.association(:address)] }
end




Factory.define :invoice do |f|
  f.sequence(:description) { |n| "Description #{n}" }
  f.sequence(:invoice_number) { |n| n }

  f.association :client
  f.association :organisation
  f.from_address_id { |c| c.client.id }
  f.to_address_id { |o| o.organisation.id }

  f.uuid Time.now.strftime("%s")
  f.state InvoiceState::STATES[InvoiceState::STATES.to_a[rand InvoiceState::STATES.size].first]
end




Factory.define :receipt do |f|
  f.sequence(:amount) { |n| n }
  f.sequence(:description) { |n| "Description #{n}" }
  f.sequence(:receipt_number) { |n| n }

  f.association :client
  f.association :organisation
  f.from_address_id { |o| o.organisation.id }
  f.to_address_id { |c| c.client.id }

  f.currency Currency::CODES[Currency::CODES.to_a[rand Currency::CODES.size].first]
  f.payment_method Payment::TYPES[Payment::TYPES.to_a[rand Payment::TYPES.size].first]
  f.received_at Time.now
  f.uuid Time.now.strftime("%s")
end
