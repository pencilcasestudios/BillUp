class Address < ActiveRecord::Base
  validates :country, :presence => true
  validates :email, :email_format => true
  validates :label, :presence => true#, :uniqueness => { scope: [addressable_id, addressable_type] }
  validates :street, :presence => true
  validates :town, :presence => true
  validates :website, :url_format => true

  belongs_to :addressable, :polymorphic => true
end
