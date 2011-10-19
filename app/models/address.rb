class Address < ActiveRecord::Base
  default_scope order("label")

  has_paper_trail

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
  
  def formatted_address
    [
      self.street.present? ? self.street : nil,
      self.town.present? ? self.town : nil,
      self.province.present? ? self.province : nil,
      self.country.present? ? self.country : nil,
      self.postal_code.present? ? self.postal_code : nil,
      self.email.present? ? self.email : nil,
      self.cell_phone_number.present? ? "Mobile: #{self.cell_phone_number}" : nil,
      self.fax_number.present? ? "Fax: #{self.fax_number}" : nil,
      self.land_line_number.present? ? "Land line: #{self.land_line_number}" : nil,
      self.website,
    ].compact.collect(&:strip).join("\n").strip
  end

  def summary
    [self.addressable.name, "(#{self.label})"].join(" ").strip
  end
end
