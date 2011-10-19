class User < ActiveRecord::Base
  has_secure_password

  has_paper_trail

  validates :cell_phone_number, :presence => true, :uniqueness => true, :phone_number_format => true
  validates :email, :presence => true, :uniqueness => true, :email_format => true
  validates :language, :presence => true
  validates :name, :presence => true
  validates :terms_of_use, :acceptance => true, :on => :create
  validates :time_zone, :presence => true
  validates :units, :presence => true, :numericality => true
  validates :username, :presence => true, :uniqueness => true

  has_many :memberships
  has_many :organisations, :through => :memberships

  attr_accessor :terms_of_use
end
