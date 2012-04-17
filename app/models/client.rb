class Client < ActiveRecord::Base
  default_scope order("name")

  belongs_to :organisation

  validates :name, :presence => true, :uniqueness => { scope: [:organisation_id] }

  has_many :addresses, :as => :addressable, :dependent => :destroy
  has_many :invoices
  has_many :receipts

  accepts_nested_attributes_for :addresses, allow_destroy: true
  
  def random_address
    self.addresses[rand self.addresses.size]
  end
end
