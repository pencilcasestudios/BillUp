class Organisation < ActiveRecord::Base
  default_scope order("name")

  has_paper_trail

  validates :leaves_left, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :name, presence: true
  validates :preferred_due_in_period, presence: true, numericality: { greater_than: 0 }
  validates :subdomain, presence: true, uniqueness: true, subdomain_format: true

  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :clients
  has_many :invoices
  has_many :members, through: :memberships, source: :user
  has_many :memberships

  accepts_nested_attributes_for :addresses, allow_destroy: true

  before_save :downcase_subdomain

  def current_address
    "Current Address"
  end
  
private

  def downcase_subdomain
    self.subdomain.downcase!
  end
end
