class Invoice < ActiveRecord::Base
  belongs_to :organisation
  belongs_to :client

  validates :description, :presence => true
  validates :from, :presence => true
  validates :from_address, :presence => true
  validates :invoice_number, :uniqueness => { scope: [:organisation_id] }
  validates :to, :presence => true
  validates :to_address, :presence => true
  validates :uuid, :presence => true, :uniqueness => true

  has_many :line_items, :dependent => :destroy
  accepts_nested_attributes_for :line_items, :allow_destroy => true

  # TODO - Implement this as a custom validation
  #before_save :due_date_is_not_before_invoice_date, :message => "due date must be after invoice date."

  def line_item_units
    line_items.group_by { |u| u.units }
  end

  def totals
    totals = {}
    self.line_item_units.each do |unit, line_items|
      unit_total = 0.0
      for line_item in line_items do 
        unit_total = unit_total + line_item.total
      end
      totals[unit] = unit_total
    end
    totals
  end

private

  def due_date_is_not_before_invoice_date
    self.due_at >= self.invoiced_at
  end
end
