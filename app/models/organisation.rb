class Organisation < ActiveRecord::Base
  default_scope order("name")
  
  validates :invoices_left, :presence => true, :numericality => true
  validates :name, :presence => true
  validates :preferred_due_in_period, :presence => true, :numericality => { :greater_than => 0 }
  validates :receipts_left, :presence => true, :numericality => true
  validates :subdomain, :presence => true, :uniqueness => true, :subdomain_format => true

  has_many :addresses, :as => :addressable, :dependent => :destroy
  has_many :clients
  has_many :invoices
  has_many :memberships
  has_many :members, :through => :memberships, :source => :user

  accepts_nested_attributes_for :addresses, :allow_destroy => true

  before_save :downcase_subdomain


  def current_address
    "Current Address"
  end
  
private

  def downcase_subdomain
    self.subdomain.downcase!
  end
end
