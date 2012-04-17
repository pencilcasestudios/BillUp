class PhoneNumber < ActiveRecord::Base
  # Generate a correctly-formatted, random, 10-digit phone number sequence
  def self.random_phone_number
    [["+",""][rand 2],"#{'%010d' % (rand 1000000000000)}"].join.strip
  end
end
