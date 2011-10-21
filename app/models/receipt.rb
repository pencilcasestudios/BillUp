class Receipt < ActiveRecord::Base
  belongs_to :client
  belongs_to :reconciliation
  belongs_to :organisation

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :currency, presence: true
  validates :from, presence: true
  validates :from_address, presence: true
  validates :payment_method, presence: true
  validates :receipt_number, presence: true, numericality: true, uniqueness: { scope: [:organisation_id] }
  validates :received_at, presence: true
  validates :to, presence: true
  validates :to_address, presence: true
  validates :uuid, presence: true, uniqueness: true
end
