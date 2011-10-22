class Receipt < ActiveRecord::Base
  default_scope order("receipt_number DESC")

  has_paper_trail

  belongs_to :client
  belongs_to :reconciliation
  belongs_to :organisation

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :currency, presence: true
  validates :from, presence: { if: :without_from_address_id? }
  validates :from_address, presence: { if: :without_from_address_id? }
  validates :payment_method, presence: true
  validates :receipt_number, presence: true, numericality: true, uniqueness: { scope: [:organisation_id] }
  validates :received_at, presence: true
  validates :to, presence: { if: :without_to_address_id? }
  validates :to_address, presence: { if: :without_to_address_id? }
  validates :uuid, presence: true, uniqueness: true

  validates :from_address_id, presence: { if: :without_from_fields? }, on: :create
  validates :to_address_id, presence: { if: :without_to_fields? }, on: :create

  attr_accessor :from_address_id
  attr_accessor :to_address_id

  before_create :fill_in_addresses

private

  def fill_in_addresses
    to_address = Address.find_by_id(self.to_address_id)
    from_address = Address.find_by_id(self.from_address_id)

    self.from = from_address.addressable.name
    self.from_address = from_address.formatted_address

    self.to = to_address.addressable.name
    self.to_address = to_address.formatted_address
  end

  def without_from_address_id?
    self.from_address_id.blank?
  end

  def without_to_address_id?
    self.to_address_id.blank?
  end
  
  def without_from_fields?
    self.from_address.blank? || self.from.blank?
  end

  def without_to_fields?
    self.to_address.blank? || self.to.blank?
  end
end
