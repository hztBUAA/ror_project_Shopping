class Address < ApplicationRecord
  belongs_to :customer
  def full_address
    "#{country}, #{city}, #{house_address}, #{phone_number}, #{greeting_name}"
  end
end
