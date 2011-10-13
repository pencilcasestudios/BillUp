class Invoice < ActiveRecord::Base
  belongs_to :organisation
  belongs_to :client

  validates :description, :presence => true
  validates :from, :presence => true
  validates :from_address, :presence => true
  validates :invoice_number, :uniqueness => { scope: [:organisation_id] }
  validates :to, :presence => true
  validates :to_address, :presence => true
end
