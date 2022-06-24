class Address < ApplicationRecord
  belongs_to :customer

  validates :customer_id, :name, :address, :postcode, presence: true
  def address_display
    '〒' + postcode + ' ' + address + ' ' + name
  end
end
