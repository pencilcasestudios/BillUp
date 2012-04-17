FactoryGirl.define do
  factory :client do
    name { |n| "Client #{n}" }
  end

  factory :invoice do
    sequence(:invoice_number) { |n| n }
    description "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    state { Invoice.random_state }
  end

  factory :organisation do
    name { |n| "Organisation #{n}" }
  end
end
