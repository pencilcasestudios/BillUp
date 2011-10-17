Factory.define :user do |f|
  f.sequence(:email) { |n| "grace#{n}@example.com" }
  f.sequence(:username) { |n| "grace#{n}" }

  # Random 12 digit, zero-padded number with an optional, leading "+"
  f.cell_phone_number [["+",""][rand 2],"#{'%010d' % (rand 1000000000000)}"].join.strip
  f.name "Grace Nyambe"
  f.language "eng"
  f.password AppConfig.test_user_password
  f.time_zone "Harare"
end




Factory.define :organisation do |f|
  f.sequence(:name) { |n| "Organisation #{n}" }
  f.sequence(:subdomain) { |n| "subdomain#{n}" }
end




Factory.define :client do |f|
  f.sequence(:name) { |n| "Client #{n}" }
  f.sequence(:organisation_id) { |n| "#{n}" }
  # TODO - build the owning organisation
end




Factory.define :invoice do |f|
  f.sequence(:description) { |n| "Description #{n}" }

  f.uuid Time.now.strftime("%s")
  f.state "invoice"
end




Factory.define :address do |f|
  f.sequence(:country) { |n| "Country #{n}" }
  f.sequence(:email) { |n| "email#{n}@example.com" }
  f.sequence(:label) { |n| "Label #{n}" }
  f.sequence(:postal_code) { |n| "Postal Code #{n}" }
  f.sequence(:province) { |n| "Province #{n}" }
  f.sequence(:street) { |n| "Street #{n}" }
  f.sequence(:town) { |n| "Town #{n}" }
  f.sequence(:website) { |n| "http://website#{n}.example.com" }

  f.cell_phone_number [["+",""][rand 2],"#{'%010d' % (rand 1000000000000)}"].join.strip
  f.fax [["+",""][rand 2],"#{'%010d' % (rand 1000000000000)}"].join.strip
  f.land_line_number [["+",""][rand 2],"#{'%010d' % (rand 1000000000000)}"].join.strip
end
