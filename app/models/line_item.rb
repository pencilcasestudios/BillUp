class LineItem < ActiveRecord::Base
  belongs_to :invoice

  validates :description, :presence => true
  validates :invoice_id, :presence => true, :numericality => true
  validates :quantity, :presence => true, :numericality => true
  validates :units, :presence => true
  validates :unit_price, :presence => true, :numericality => true
end
