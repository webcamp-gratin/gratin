class Order < ApplicationRecord
  belongs_to :customer
  has_many :ordered_items, dependent: :destroy
  enum payment_method: { クレジットカード: 0, 銀行振込: 1 }

  def address_display
    '〒' + postcode + ' ' + address + ' ' + name
  end


end
