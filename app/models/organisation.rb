class Organisation < ActiveRecord::Base
  validates :name, :presence => true
  validates :subdomain, :presence => true, :uniqueness => true
  validates :invoices_left, :presence => true, :numericality => true
  validates :receipts_left, :presence => true, :numericality => true

  has_many :memberships
  has_many :members, :through => :memberships, :source => :user
end
