class Organisation < ActiveRecord::Base
  default_scope order("name")

  has_paper_trail

  validates :leaves_left, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :name, presence: true
  validates :preferred_due_in_period, presence: true, numericality: { greater_than: 0 }
  validates :subdomain, presence: true, uniqueness: true, subdomain_format: true

  has_many :clients
  has_many :invoices
  has_many :memberships
  has_many :receipts

  has_many :addresses, as: :addressable, dependent: :destroy

  has_many :members, through: :memberships, source: :user

  accepts_nested_attributes_for :addresses, allow_destroy: true

  before_save :downcase_subdomain

  def current_address
    "Current Address"
  end
  
  # Methods to help in testing
  def random_address
    self.addresses[rand self.addresses.size]
  end

  def random_client
    self.clients[rand self.clients.size]
  end

private

  def downcase_subdomain
    self.subdomain.downcase!
  end
end
