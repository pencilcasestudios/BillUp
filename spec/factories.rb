Factory.define :user do |f|
  f.sequence(:cell_phone_number) { |n| "097 519 #{n}" }
  f.sequence(:email) { |n| "grace#{n}@example.com" }
  f.sequence(:username) { |n| "grace#{n}" }

  f.name "Grace Nyambe"
  f.language "eng"
  f.password AppConfig.test_user_password
  f.time_zone "Harare"
end




Factory.define :organisation do |f|
  f.sequence(:name) { |n| "Organisation #{n}" }
  f.sequence(:subdomain) { |n| "subdomain#{n}" }
end
