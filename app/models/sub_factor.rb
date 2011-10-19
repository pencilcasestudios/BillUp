class SubFactor < ActiveRecord::Base
  has_paper_trail

  belongs_to :line_item

  validates :amount, :presence => true, :numericality => true
  validates :units, :presence => true
end
