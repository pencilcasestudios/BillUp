class Invoice < ActiveRecord::Base
  default_scope order("invoice_number DESC")

  has_paper_trail

  belongs_to :organisation
  belongs_to :client

  validates :description, presence: true
  validates :from, presence: true
  validates :from_address, presence: true
  validates :invoice_number, presence: true, uniqueness: { scope: [:organisation_id] }, numericality: { greater_than: 0 }
  validates :state, presence: true
  validates :to, presence: true
  validates :to_address, presence: true
  validates :uuid, presence: true, uniqueness: true

  has_many :line_items, dependent: :destroy

  accepts_nested_attributes_for :line_items, allow_destroy: true, reject_if: :all_blank

  attr_accessor :to_address_id
  attr_accessor :from_address_id

  

  # TODO - Implement this as a custom validation
  #before_save :due_date_is_not_before_invoice_date, message: "due date must be after invoice date."
  before_create :fill_in_addresses

  def line_item_units
    line_items.group_by { |u| u.currency }
  end

  def totals
    totals = {}
    self.line_item_units.each do |currency, line_items|
      unit_total = 0.0
      for line_item in line_items do 
        unit_total = unit_total + line_item.total
      end
      totals[currency] = unit_total
    end
    totals
  end

  def file_name
    "#{I18n.t("views.invoices.show.copy.states.#{self.state}")} #{self.invoice_number} #{I18n.t("views.invoices.show.labels.to")} #{self.client.name}.pdf"
  end

private

  #def due_date_is_not_before_invoice_date
  #  self.due_at >= self.invoiced_at
  #end
  
  def fill_in_addresses
    if (to_address_id.present? && to_address_id.present?)
      to_address = Address.find_by_id(self.to_address_id)
      from_address = Address.find_by_id(self.from_address_id)
    
      self.from = from_address.addressable.name
      self.from_address = from_address.formatted_address

      self.to = to_address.addressable.name
      self.to_address = to_address.formatted_address
    end
  end
end
