Factory.define :user do |f|
  f.sequence(:cell_phone_number) { |n| "097 519 #{n}" }
  f.sequence(:email) { |n| "florence#{n}@example.com" }
  f.sequence(:username) { |n| "florence#{n}" }

  f.name "Florence Nawale"
  f.language "eng"
  f.password "secret"
  f.time_zone "(GMT+02:00) Harare"
end




Factory.define :organisation do |f|
  f.sequence(:name) { |n| "Organisation #{n}" }
  f.sequence(:subdomain) { |n| "subdomain#{n}" }
end
