class Organisation < ActiveRecord::Base
  default_scope order("name")
  
  validates :name, :presence => true
  validates :subdomain, :presence => true, :uniqueness => true, :subdomain_format => true
  validates :invoices_left, :presence => true, :numericality => true
  validates :receipts_left, :presence => true, :numericality => true

  has_many :addresses, :as => :addressable  
  has_many :clients
  has_many :invoices
  has_many :memberships
  has_many :members, :through => :memberships, :source => :user

  before_save :downcase_subdomain


  def current_address
    "Current Address"
  end
  
private

  def downcase_subdomain
    self.subdomain.downcase!
  end
end
