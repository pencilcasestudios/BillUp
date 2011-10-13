class LineItem < ActiveRecord::Base
  belongs_to :invoice

  validates :description, :presence => true
  validates :invoice_id, :presence => true, :numericality => true
  validates :quantity, :presence => true, :numericality => true
  validates :units, :presence => true
  validates :unit_price, :presence => true, :numericality => true

  has_many :sub_factors, :dependent => :destroy
  accepts_nested_attributes_for :sub_factors, :allow_destroy => true

  def total
    running_multiple = 1.0
    self.sub_factors.each do |factor|
      running_multiple = running_multiple * factor.amount
    end
    running_multiple * self.quantity * self.unit_price
  end
end
