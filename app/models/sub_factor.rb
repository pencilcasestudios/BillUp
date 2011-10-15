class SubFactor < ActiveRecord::Base
  belongs_to :line_item

  validates :amount, :presence => true, :numericality => true
  validates :units, :presence => true
end
