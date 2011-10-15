class Address < ActiveRecord::Base
  default_scope order("label")

  validates :label, :presence => true#, :uniqueness => { scope: [addressable_id, addressable_type] }
  validates :street, :presence => true
  validates :town, :presence => true
  validates :country, :presence => true

  validates :cell_phone_number, :phone_number_format => true, :allow_blank => true
  validates :email, :email_format => true, :allow_blank => true
  validates :fax_number, :phone_number_format => true, :allow_blank => true
  validates :land_line_number, :phone_number_format => true, :allow_blank => true
  validates :website, :url_format => true, :allow_blank => true

  belongs_to :addressable, :polymorphic => true
end
