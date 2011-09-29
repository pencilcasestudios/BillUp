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
