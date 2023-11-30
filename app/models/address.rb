class Address < ApplicationRecord
  belongs_to :order,optional: true
  belongs_to :customer
  validates :country, :city, :house_address, :phone_number, :greeting_name, presence: true
  def full_address
    "#{country}, #{city}, #{house_address}, #{phone_number}, #{greeting_name}"
  end
end
